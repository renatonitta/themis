Themis::Application.routes.draw do |map|
  resources :sections do
    resources :posts
  end

  devise_for :users
  root :to => "posts#all"
end
