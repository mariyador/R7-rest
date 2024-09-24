Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  namespace :api do
    namespace :v1 do
      resources :members do
        resources :facts
      end
    end
  end

  get '/test', to: 'test#show'
end