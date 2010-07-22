task :build => ['db:migrate', :spec] do 
  system "rm rerun.txt"
  raise unless system "rake cucumber RAILS_ENV=test"
end
