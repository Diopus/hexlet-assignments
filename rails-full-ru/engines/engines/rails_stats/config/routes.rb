# frozen_string_literal: true

RailsStats::Engine.routes.draw do
  # BEGIN
  root to: 'stats#index'
  resources :rails_stats
  # END
end
