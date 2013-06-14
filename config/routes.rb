Buddylist::Application.routes.draw do
  get 'blogtags/:tag', to: 'blogpostings#index', as: :blogtag
  get 'filetags/:tag', to: 'filepostings#index', as: :audiotag
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "accept_friendship/:id" => "friendships#accept", :as => "accept_friendship"

  resources :users
  resources :friendships
  resources :sessions
  resources :blogpostings do
    resources :comments, :only => [:create, :destroy]
    get :autocomplete_tag_name, :on => :collection
  end
  resources :filepostings do
    resources :comments, :only => [:create, :destroy]
    get :autocomplete_tag_name, :on => :collection
  end
  resources :postings do
    resources :comments, :only => [:create, :destroy]
  end

  root :to => 'postings#index'

end
