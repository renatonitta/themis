Themis::Application.routes.draw do |map|
  devise_for :admins, :users
  resources :users
  resources :sections do
    resources :posts do
      member do
        match 'approve' => 'posts#approve', :as => 'approve'
      end
      collection do
        match 'pages/:page' => 'posts#index', :as => 'page'
      end
    end
  end
  namespace 'admin' do
    resources :users
    resources :sections
  end
  match 'sitemap.:format', :to => 'application#sitemap', :as => 'sitemap'
  match 'tags/:tag', :to => 'posts#by_tag', :as => 'tags'
  match 'posts.:format', :to => 'posts#all'
  match 'posts/pages/:page', :to => 'posts#all', :as => 'posts_page'
  root :to => "posts#all"
end
