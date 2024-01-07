# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  root 'home#index'
  scope ('/:locale'), locale: /en|ru/ do
    resources :posts do
      resources :comments, module: :posts
    end
  end
  # END
  get "up" => "rails/health#show", as: :rails_health_check
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
