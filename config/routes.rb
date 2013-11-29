DeviseExample::Application.routes.draw do

  resources :bids
  resources :servicerequests

  devise_for :providers
  devise_for :users

  get '/token' => 'home#token', as: :token
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
  resources :home, only: :index
  resources :providers, :only => [:index, :show] 

  root 'home#index'

end
