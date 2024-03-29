# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end

  resources :lounges do
    resources :display_images, only: [:destroy]
    resources :logos, only: [:destroy]
    resources :events, shallow: true
    resources :memberships, shallow: true
    resources :special_offers, shallow: true
  end

  resources :events do
    resources :event_flyers, only: [:destroy]
    resources :rsvps, shallow: true
  end

  resources :lounges, only: :index do
    member do
      post 'toggle_favorite', to: 'lounges#toggle_favorite'
    end
  end

  resources :memberships do
    member do
      post :activate
      post :deactivate
    end
  end

  resources :notifications do
    member do
      post :read
      post :unread
    end
  end

  resources :rsvps do
    member do
      patch :mark_attended
      patch :mark_unattended
    end
  end

  resources :special_offers do
    resources :special_offer_flyers, only: [:destroy]
  end

  resources :subscriptions

  namespace :purchase do
    post 'create-monthly-email-checkout-session', to: 'checkouts#create_monthly_email_checkout_session'
    post 'create-monthly-email-and-text-checkout-session', to: 'checkouts#create_monthly_email_and_text_checkout_session'
    post 'create-yearly-email-checkout-session', to: 'checkouts#create_yearly_email_checkout_session'
    post 'create-yearly-email-and-text-checkout-session', to: 'checkouts#create_yearly_email_and_text_checkout_session'
  end

  get 'my_lounges', to: 'lounges#my_lounges'
  get 'pricing', to: 'price_listings#pricing'
  get 'success', to: 'purchase/checkouts#success'
  get 'billing', to: 'billing#show'

  authenticate :user, ->(u) { u.admin? } do
    mount Resque::Server.new, at: '/jobs'
  end
end
