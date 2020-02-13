Rails.application.routes.draw do
  resources :games, param: :pin, only: [:create] do
    member do
      post :join
      get :status
    end
  end

  resources :rounds, only: [] do
    collection do
      get :status
      get :card_list
      post :submit_answer
      post :submit_winner
    end
  end
  resources :sessions, only: [:create]
end
