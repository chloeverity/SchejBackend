# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  namespace :api do
    namespace :v1 do
      resources :problems
      resources :services
      devise_scope :user do
        post '/sign_in', to: 'sessions#create'
        post '/sign_up' => 'registrations#create'
        delete '/sign_out', to: 'sessions#destroy'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
