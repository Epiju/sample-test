Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    post 'auth/login' => 'login#login'

    get 'users/events' => 'users#events'
    post 'users/reserve' => 'users#reserve'
  end
end
