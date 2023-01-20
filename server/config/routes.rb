Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
    confirmations:  'user/confirmations',
    registrations: 'user/registrations',
    sessions: "user/sessions"
  }
  resources :users, only: [:show] do
    member do
      get '/:follow_option', to: "users#follow_detail"
      post :follow
      delete :unfollow
    end
  end
  resources :tweets do
    resources :comments
    post 'like', to: "likes#create"
    delete "unlike", to: "likes#destroy"
  end

  match '*unmatched', to: 'application#routing_error', via: :all
end
