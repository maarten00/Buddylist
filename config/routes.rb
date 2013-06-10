Buddylist::Application.routes.draw do
  resources :audiopostings

  get 'blogtags/:tag', to: 'blogpostings#index', as: :blogtag
  get 'audiotags/:tag', to: 'audiopostings#index', as: :audiotag
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions
  resources :blogpostings do
    resources :comments, :only => [:create, :destroy]
  end
  resources :audiopostings do
    resources :comments, :only => [:create, :destroy]
  end


  root :to => 'blogpostings#index'

end
