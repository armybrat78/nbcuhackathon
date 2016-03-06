require 'spec_helper'

describe Api::V1::UsersController do
 before(:each) { request.headers['Accept'] = "application/vnd.nbcuhackathon.v1" }

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      #user_response = JSON.parse(response.body, symbolize_names: true)
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end

    it { expect(response.status).to eq(200) }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { expect(response.status).to eq(201)  }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { expect(response.status).to eq(422)  }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id,
                         user: { points: 50 } }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:points]).to eql 50
      end

      it { expect(response.status).to eq(200)  }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @email = @user.email
        patch :update, { id: @user.id,
                         user: { points: "notallowed@sorry.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:points]).to include "is not a number"
      end

      it { expect(response.status).to eq(422)  }
    end

    context "when you try to update email" do
      before(:each) do
        @user = FactoryGirl.create :user
        @email = @user.email
        patch :update, { id: @user.id,
                         user: { email: "notallowed@sorry.com" } }, format: :json
      end
      it "does not change the email" do
        expect(@user.email).not_to equal("notallowed@sorry.com")
      end
    end
  end

  describe "DELETE #destroy" do
  before(:each) do
    @user = FactoryGirl.create :user
    delete :destroy, { id: @user.id }, format: :json
  end

  it { expect(response.status).to eq(204)  }

end

end
