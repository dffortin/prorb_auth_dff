Rails.application.routes.draw do
  resources :posts
  get "dashboards/index", as: :dashboards
  resources :logins, only: %i[new create destroy]
  resources :registrations, only: %i[new create]

  root "logins#new"
end
