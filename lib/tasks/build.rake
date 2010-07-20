task :build => ['db:migrate', :spec] do
  system 'rm rerun.txt'
  execute_command 'cucumber'
end

private

def execute_command(cmd)
  raise unless system cmd
end
