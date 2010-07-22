namespace :db do
  task :create_admin => :environment do
    Admin.create! :email => 'admin@themis.com', :password => 'themis'
  end
end
