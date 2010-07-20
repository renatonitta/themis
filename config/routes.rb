Themis::Application.routes.draw do |map|
  resources :sections do
    resources :posts
  end
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  match 'tags/:tag', :to => 'posts#by_tag', :as => 'tags'
  match 'posts.:format', :to => 'posts#all'
  root :to => "posts#all"
end
