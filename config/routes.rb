
Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show, :create, :update, :destroy],
    defaults: { format: :json }
end
