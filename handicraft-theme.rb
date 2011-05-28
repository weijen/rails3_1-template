if File.directory?(File.dirname(__FILE__) + "/handicraft-theme")
    # for layout
    run "rm app/views/layouts/application.html.erb"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/layouts/application.html.erb app/views/layouts/application.html.erb"

    # for navigator
    run "mkdir app/views/common"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/menu/_main_navigation.html.erb app/views/common/_main_navigation.html.erb"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/menu/_user_navigation.html.erb app/views/common/_user_navigation.html.erb"

    # for css
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/stickie.css app/assets/stylesheets/"
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/simple_form.css app/assets/stylesheets/"

    # handicraft-theme required
    run "mkdir app/assets/stylesheets/handicraft/"
    run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/handicraft/* app/assets/stylesheets/handicraft/"

    #select a handicraft-theme
    theme = ask("選擇您要使用的theme:\n 1. aqua\n 2. blue\n 3. gray\n 4. red\n", :green)

    case theme
    when "1"
        run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/aqua.css app/assets/stylesheets/handicraft/"
    when "2"
        run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/blue.css app/assets/stylesheets/handicraft/"
    when "3"
        run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/gray.css app/assets/stylesheets/handicraft/"
    when "4"
        run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/red.css app/assets/stylesheets/handicraft/"
    else
        run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/blue.css app/assets/stylesheets/handicraft/"
    end
    run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/stylesheets/themes/core.css app/assets/stylesheets/handicraft/"

    # helper
    run "cp #{File.dirname(__FILE__)}/handicraft-theme/handicraft_helper.rb app/helpers/"

    #copy scaffold template
    run "cp -R #{File.dirname(__FILE__)}/handicraft-theme/templates lib/"
else
    say "Handicraft Theme not exist, please contact with Handlino", :red
end
