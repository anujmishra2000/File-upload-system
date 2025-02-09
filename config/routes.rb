Rails.application.routes.draw do
  get "shared_files/show"
  get "url/show"
  root "file_uploads#index"
  devise_for :users

  resources :file_uploads, only: [:index, :new, :create, :destroy] do
    member do
      post :generate_public_url
    end
  end

  get '/shared/:public_url', to: 'file_uploads#short_url_redirect', as: :public_url

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
