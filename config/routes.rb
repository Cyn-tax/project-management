# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :teams
      resources :projects
      resources :members
      resources :member_projects, only: [:create]
    end
  end
end
