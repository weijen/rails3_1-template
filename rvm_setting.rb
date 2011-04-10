begin
    require 'rvm'
rescue
    raise "RVM ruby lib is currently unavailable. You can install rvm lib use: gem install rvm"
end

@rvm_env = "#{RVM.current.environment_name}@#{app_name}"

if yes?("你目前的ruby版本為#{RVM.current.environment_name}，將作為#{app_name}的預設環境，並將gemset設為#{@rvm_env}?", :green)

  @rvm_env = "#{RVM.current.environment_name}@#{app_name}"
  
  run "rvm #{RVM.current.environment_name}"
  
  template( (File.dirname(__FILE__) + '/templates/rvmrc.tt'), ".rvmrc")
  
  say "Creating RVM gemset #{@rvm_env}"
  RVM.gemset_create @rvm_env
  
  say"Trusting project's .rvmrc"
  run "rvm rvmrc trust"
  
  say "Switching to use RVM gemset #{@rvm_env}"
  RVM.gemset_use! @rvm_env
end


