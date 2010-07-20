Themis::Application.routes.draw do |map|
  resources :sections do
    resources :posts
  end

  match 'tags/:id', :to => 'posts#by_tag', :as => 'tags'

  devise_for :users, :controllers => { :sessions => "admin/sessions" }
  root :to => "posts#all"
end
