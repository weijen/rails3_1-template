if File.directory?(File.dirname(__FILE__) + "/handicraft-theme")
    run "rm app/views/layouts/application.html.erb"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/layouts/application.html.erb app/views/layouts/application.html.erb"

    run "mkdir app/views/common"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/menu/_main_navigation.html.erb app/views/common/_main_navigation.html.erb"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/menu/_user_navigation.html.erb app/views/common/_user_navigation.html.erb"

    run "cp #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/stickie.css public/stylesheets/"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/simple_form.css public/stylesheets/"
    run "mkdir public/stylesheets/handicraft/"
    run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/handicraft/* public/stylesheets/handicraft/"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/handicraft_helper.rb app/helpers/"

    #copy scaffold template
    run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/templates lib/"
else
    say "Handicraft Theme not exist, please contact with Handlino", :red
end
