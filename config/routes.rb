Buddylist::Application.routes.draw do
  get 'blogtags/:tag', to: 'blogpostings#index', as: :blogtag
  get 'filetags/:tag', to: 'filepostings#index', as: :filetag
  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "accept_friendship/:id" => "friendships#accept", as: "accept_friendship"

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end

  concern :autocompletable do
    get :autocomplete_tag_name, on: :collection
  end

  resources :sessions
  resources :users
  resources :friendships
  resources :personalpostings
  resources :blogpostings, concerns: [:commentable, :autocompletable]
  resources :filepostings, concerns: [:commentable, :autocompletable]
  resources :postings, concerns: [:commentable]

  root :to => 'postings#index'

end
