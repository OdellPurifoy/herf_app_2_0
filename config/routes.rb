Rails.application.routes.draw do
  resources :lounges do
    resources :events, shallow: true
    resources :memberships, shallow: true
  end

  resources :lounges, only: :index do
    member do
      post 'toggle_favorite', to: "lounges#toggle_favorite"
    end
  end

  get 'my_lounges', to: "lounges#my_lounges"
   
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users

  root "home#index"
end
