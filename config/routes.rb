Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  
  resources :conventions, except: :destroy, constraints: lambda { |req| req.format == :json } do
    resources :convention_years, only: [:index, :new, :create]
  end
  resources :convention_years, only: :update, constraints: lambda { |req| req.format == :json } do
    resources :photo_shoots, only: [:index, :new, :create]
  end
  resources :photo_shoots, only: :update, constraints: lambda { |req| req.format == :json }
end

