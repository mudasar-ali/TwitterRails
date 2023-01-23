Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
    confirmations:  'user/confirmations',
    registrations: 'user/registrations',
    sessions: "user/sessions"
  }
  resources :users, only: [:show] do
   resources :follows, only: [:index, :create]
   member do
    delete "unfollow", to: "follows#destroy"
   end
  end
  resources :tweets do
    resources :comments
    member do
      post 'like', to: "likes#create"
      delete "unlike", to: "likes#destroy"
    end
  end

  match '*unmatched', to: 'application#routing_error', via: :all
end
