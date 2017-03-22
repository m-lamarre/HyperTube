Rails.application.routes.draw do
  devise_for :users, controllers: {
        confirmations:      'users/confirmations',
        passwords:          'users/passwords',
        registrations:      'users/registrations',
        sessions:           'users/sessions',
        unlocks:            'users/unlocks',
        # omniauth_callbacks: 'users/omniauth_callbacks',
      }
  devise_scope :user do
    get '/users/:id(.:format)' => 'users/sessions#show'
  end

  root 'movies#index'
end
