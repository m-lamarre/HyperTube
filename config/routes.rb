Rails.application.routes.draw do
  devise_for :users

  root 'movies#index'

  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'

  delete '/sign_out', to: 'sessions#destroy'

  get    '/sign_up',  to: 'registrations#new'
  get    '/cancel',   to: 'registrations#cancel'
  get    '/edit',     to: 'registrations#edit'
end
