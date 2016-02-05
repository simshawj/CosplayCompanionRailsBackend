Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  
  resources :conventions, except: :destroy do
    resources :convention_years, only: [:index, :new, :create]
  end
  resources :convention_years, except: :destroy do
    resources :photo_shoots, only: [:index, :new, :create]
  end
  resources :photo_shoots, except: :destroy
end

