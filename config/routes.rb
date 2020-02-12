Rails.application.routes.draw do
  resources :games, param: :pin, only: [:create] do
    member do
      post :join
      get :status
    end
  end

  resources :sessions, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
