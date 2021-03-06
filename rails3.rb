question_color = :green
# remove files
run "rm README"
run "rm public/index.html"
run "rm app/assets/images/rails.png"
run "cp config/database.yml config/database.yml.example"

# use rvm
if yes?("Use rvm?", question_color)
    apply File.join(File.dirname(__FILE__), "rvm_setting.rb")
end

# i18n for Tranditional Chinese
append_to_file "config/locales/en.yml", "  sitename: #{app_name}"
if yes?("default language is Tranditional Chinese?", question_color)
    run "cp #{(File.dirname(__FILE__))}/locale/zh-TW.yml config/locales/"
    append_to_file "config/locales/zh-TW.yml", "  sitename: #{app_name}"
end

# set development database.yml
case options[:database]
when "mysql"
    template "#{(File.dirname(__FILE__))}/database/mysql.tt", "config/database.yml"
when "sqlite3"
end

# install gems
gem 'simple_form'
gem 'will_paginate'
gem 'meta_search'

# copy files from handicraft-theme
if yes?("Use Handicraft Themes?", question_color)
    apply File.join(File.dirname(__FILE__), "handicraft-theme.rb")
end

# create root path
generate :controller, "Welcome index"
route "root :to => 'welcome#index'"

# copy files
#file 'script/watchr.rb', File.read("#{File.dirname(rails_template)}/watchr.rb")
file 'lib/tasks/dev.rake', File.read("#{File.dirname(rails_template)}/dev.rake")

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
.rvmrc
Gemfile.lock
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
