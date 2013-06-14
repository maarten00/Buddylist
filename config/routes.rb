Buddylist::Application.routes.draw do
  resources :filepostings

  get 'blogtags/:tag', to: 'blogpostings#index', as: :blogtag
  get 'filetags/:tag', to: 'filepostings#index', as: :audiotag
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "accept_friendship" => "friendships#accept", :as => "accept_friendship"
  resources :friendships
  resources :users
  resources :sessions
  resources :blogpostings do
    resources :comments, :only => [:create, :destroy]
  end
  resources :filepostings do
    resources :comments, :only => [:create, :destroy]
  end


  root :to => 'blogpostings#index'

end
