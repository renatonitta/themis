Themis::Application.routes.draw do |map|
  devise_for :admins, :users
  resources :users
  resources :sections do
    resources :posts do
      member do
        match 'approve' => 'posts#approve', :as => 'approve'
      end
    end
  end
  match 'tags/:tag', :to => 'posts#by_tag', :as => 'tags'
  match 'posts.:format', :to => 'posts#all'
  root :to => "posts#all"
end
