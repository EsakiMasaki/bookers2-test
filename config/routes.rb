Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about"

  resources :users,only: [:index,:show,:edit]
  resources :books,only: [:index,:show,:edit,:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
