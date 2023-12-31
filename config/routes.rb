Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :comments, :posts, :tags, :users
  get "user_simple", to: "users#showSimple"
  post "comments/:id/like", to: "comments#like"
  post "comments/:id/dislike", to: "comments#dislike"
  post "posts/:id/like", to: "posts#like"
  post "posts/:id/dislike", to: "posts#dislike"
end
