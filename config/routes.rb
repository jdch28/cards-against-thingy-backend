Rails.application.routes.draw do
  resources :games, param: :pin, only: [:create] do
    member do
      post :join
      get :status
    end
  end

  resources :sessions, only: [:create]
end
