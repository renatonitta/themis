Themis::Application.routes.draw do |map|
  resources :sections

  resources :posts

  devise_for :users
  root :to => "posts#index"
end
