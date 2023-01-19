Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
    confirmations:  'user/confirmations'
  }
  post '/users/:id/follow', to: "follows#create"
  delete '/users/:id/unfollow', to: "follows#destroy"
  get '/users/:id/:follow_option', to: "follows#index"

  resources :tweets

  match '*unmatched', to: 'application#routing_error', via: :all
end
