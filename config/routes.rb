# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :teams do
        resources :members, only: [:index], on: :member, module: :teams
      end
      resources :projects do
        resources :members, only: [:index], on: :member, module: :projects
      end
      resources :members
      resource :member_projects, only: [:create]
    end
  end
end
