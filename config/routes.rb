Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resource :movie, only: %i(show)

  get 'users/:id', to: 'users#show'

  post '/users/profile', to: 'users#update'

  get 'movie/:source/:id', to: 'movies#show'

  get 'movie/search', to: 'movies#search'

  get 'movie/play/:source/:id/:quality', to: 'movies#play'

  post 'movie/play/:source/:id/:quality/comment', to: 'comments#create'

  namespace :api do
    namespace :v1 do
      get ':source/:id/:quality/download_url', to: 'movie_downloader#get_download_url', defaults: { format: :json }
    end
  end

  authenticated :user do
    root to: 'movies#index'
  end

  root to: 'visitors#index'
end
