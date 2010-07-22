task :prepare do
  system "rm rerun.txt"
  system "bundle install"
end

task :build => [:prepare, 'db:migrate', :spec, :cucumber]
