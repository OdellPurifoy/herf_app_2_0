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
    resources :events, shallow: true
    resources :memberships, shallow: true
    resources :special_offers, shallow: true
  end

  resources :events do
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

  resources :subscriptions
  resources :webhooks, only: :create

  namespace :purchase do
    resources :checkouts
  end

  resources :billing, only: :create

  get 'my_lounges', to: 'lounges#my_lounges'
  get 'pricing', to: 'price_listings#pricing'
  get 'success', to: 'purchase/checkouts#success'
  # get 'billing', to: 'billing#show'

  authenticate :user, ->(u) { u.admin? } do
    mount Resque::Server.new, at: '/jobs'
  end
end
