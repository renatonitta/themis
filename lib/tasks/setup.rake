namespace :db do
  task :create_user => :environment do
    User.create! :name => 'User', :email => 'user@themis.com', :password => 'themis'
  end
end
