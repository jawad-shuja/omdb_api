Rails.application.routes.draw do
  resources :apidocs, only: [:index]
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :movies, only: %w[show index update] do
        resources :shows, only: %w[index]
        resources :reviews, only: %w[create]
      end
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/login',
               sign_out: 'api/logout',
               registration: 'api/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
