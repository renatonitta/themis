Themis::Application.routes.draw do |map|
  resources :sections do
    resources :posts
  end

  devise_for :users
  match 'tags/:id', :to => 'posts#by_tag', :as => 'tags'
  root :to => "posts#all"
end
