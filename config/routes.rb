# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  namespace :api do
    namespace :v1 do
      resources :shifts
      resources :problems
      resources :services
      get '/shiftsbyuser/:user_id', to: 'shifts#show_by_id', as: 'usershifts'
      devise_scope :user do
        get '/sign_in', to: 'sessions#new'
        get '/sign_up', to: 'registrations#new'
        post '/sign_in', to: 'sessions#create'
        post '/sign_up' => 'registrations#create'
        delete '/sign_out', to: 'sessions#destroy'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
