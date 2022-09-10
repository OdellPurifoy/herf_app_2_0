Rails.application.routes.draw do
  resources :lounges do
    resources :events, shallow: true
  end

  resources :lounges, only: :index do
    member do
      post 'toggle_favorite', to: "lounges#toggle_favorite"
    end
  end
   
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
