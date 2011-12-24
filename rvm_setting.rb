#encoding: UTF-8
begin
    require 'rvm'
rescue
    raise "RVM ruby lib is currently unavailable. You can install rvm lib use: gem install rvm"
end

@rvm_env = "#{RVM.current.environment_name}@#{app_name}"

if yes?("你目前的ruby版本為#{RVM.current.environment_name}，將作為#{app_name}的預設環境，並將gemset設為#{@rvm_env}?", :green)

  @rvm_env = "#{RVM.current.environment_name}@#{app_name}"
  
  run "rvm use #{@rvm_env} --create --rvmrc"
end


