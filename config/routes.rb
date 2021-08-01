Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :movies, only: %w[show index update] do
      resources :shows, only: %w[index]
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
