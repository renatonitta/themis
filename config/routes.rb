Themis::Application.routes.draw do |map|
  resources :sections do
    resources :posts
  end

  devise_for :users, :controllers => { :sessions => "admin/sessions" }
  root :to => "posts#all"
end
