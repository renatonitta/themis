Themis::Application.routes.draw do |map|
  devise_for :admins

  resources :sections do
    resources :posts do
      member do
        match 'approve' => 'posts#approve', :as => 'approve'
      end
    end
  end
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  match 'tags/:tag', :to => 'posts#by_tag', :as => 'tags'
  match 'posts.:format', :to => 'posts#all'
  root :to => "posts#all"
end
