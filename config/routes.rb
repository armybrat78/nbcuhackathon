
Rails.application.routes.draw do
  get '/leaderboard' => 'leaderboard#index'
  resources :users, :only => [:show, :create, :update, :destroy],
    defaults: { format: :json }
end
