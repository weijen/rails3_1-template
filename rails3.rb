question_color = :green
# remove files
run "rm README"
run "rm public/index.html"
run "rm public/images/rails.png"
run "cp config/database.yml config/database.yml.example"

say "database: #{options[:database]}", :red
# use rvm
if yes?("Use rvm?", question_color)
    apply File.join(File.dirname(__FILE__), "rvm_setting.rb")
end

# i18n for Tranditional Chinese
append_to_file "config/locales/en.yml", "  sitename: #{app_name}"
if yes?("default language is Tranditional Chinese?", :green)
    run "cp #{(File.dirname(__FILE__))}/locale/zh-TW.yml config/locales/"
    append_to_file "config/locales/zh-TW.yml", "  sitename: #{app_name}"
end

# set development database.yml
case options[:database]
when "mysql"
    gem "mysql2"
    template "#{(File.dirname(__FILE__))}/database/mysql.tt", "config/database.yml"
when "sqlite3"
    gem 'sqlite3-ruby', :require => 'sqlite3'
end

# install gems
run "rm Gemfile"
file 'Gemfile', File.read("#{File.dirname(rails_template)}/Gemfile")

# set Devise
if yes?("Use Devise?", question_color)
  devise = true
  gem "devise"
  if yes?("Do you want to input your first user model name?")
        @user_model_name = ask("model name => ")
  end
end

# bundle install
begin
    run "gem install rails --no-ri --no-rdoc"
    run "gem install bundler --no-ri --no-rdoc"
rescue
    raise "Can't install bundler"
end

run "bundle install"

### after bundle install  ###

# copy files from handicraft-theme
if yes?("Use Handicraft Themes?", question_color)
    apply File.join(File.dirname(__FILE__), "handicraft-theme.rb")
end

# create root path
generate :controller, "Welcome index"
route "root :to => 'welcome#index'"

# generate devise
if devise
  apply File.join(File.dirname(__FILE__), "devise.rb")
end

# generate simple_form
generate "simple_form:install"

# generate rspec
generate "rspec:install"


# copy files
file 'script/watchr.rb', File.read("#{File.dirname(rails_template)}/watchr.rb")
file 'lib/tasks/dev.rake', File.read("#{File.dirname(rails_template)}/dev.rake")

# remove active_resource and test_unit
gsub_file 'config/application.rb', /require 'rails\/all'/, <<-CODE
  require 'rails'
  require 'active_record/railtie'
  require 'action_controller/railtie'
  require 'action_mailer/railtie'
CODE

# install jquery
run "curl -L http://code.jquery.com/jquery.min.js > public/javascripts/jquery.js"
run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

gsub_file 'config/application.rb', /(config.action_view.javascript_expansions.*)/, 
                                   "config.action_view.javascript_expansions[:defaults] = %w(jquery rails)"

# add time format
environment 'Time::DATE_FORMATS.merge!(:default => "%Y/%m/%d %I:%M %p", :ymd => "%Y/%m/%d")'

# .gitignore
append_file '.gitignore', <<-CODE
config/database.yml
Thumbs.db
.DS_Store
tmp/*
coverage/*
*.swp
CODE

# keep tmp and log
run "touch tmp/.gitkeep"
run "touch log/.gitkeep"

# git commit
git :init
git :add => '.'
git :add => 'tmp/.gitkeep -f'
git :add => 'log/.gitkeep -f'
git :commit => "-a -m 'initial commit'"
