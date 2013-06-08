Buddylist::Application.routes.draw do
  get 'tags/:tag', to: 'blogpostings#index', as: :tag
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions
  resources :blogpostings do
    resources :comments, :only => [:create, :destroy]
  end

  root :to => 'users#index'

end
