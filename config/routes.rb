Rails.application.routes.draw do
  root "file_uploads#index"
  devise_for :users

  resources :file_uploads, only: [:index, :new, :create, :destroy] do
    member do
      post :share
    end
  end

  get "/files/:short_url", to: "file_uploads#public_view", as: "file_upload_short"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
