class UsersController < ApplicationController
  # before_create :generate_user_token!
  skip_before_filter  :verify_authenticity_token, only: [:create]

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
  user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200, location: [user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end


  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :points)
    end

     def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
