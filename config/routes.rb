require "resque/server"

Rails.application.routes.draw do
  resources :rsvps
  root "home#index"
  devise_for :users
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
  
  resources :lounges do
    resources :events, shallow: true
    resources :memberships, shallow: true
    resources :special_offers, shallow: true
  end

  resources :lounges, only: :index do
    member do
      post 'toggle_favorite', to: "lounges#toggle_favorite"
    end
  end

  authenticate :user, -> (u) { u.admin? } do
    mount Resque::Server.new, at: '/jobs'
  end

  get 'my_lounges', to: "lounges#my_lounges"
end
