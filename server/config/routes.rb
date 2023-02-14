Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
    confirmations:  'user/confirmations',
    token_validations: 'user/token_validations',
    registrations: 'user/registrations',
    sessions: "user/sessions"
  }
  resources :users, only: [:show, :update] do
    collection do
      get :search
      post :transcribe
    end
   resources :follows, only: [:index, :create] do
    collection do
     delete "unfollow", to: "follows#destroy"
    end
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
