generate 'devise:install'
say "現在設定devise Model: #{@user_model_name}"
if @user_model_name
  generate "devise #{@user_model_name.capitalize}"
  append_to_file "db/seeds.rb" do
    "#{@user_model_name.capitalize}.create(:email => 'admin@example.com', :password => 'handlino', :password_confirmation => 'handlino')"
  end

  insert_into_file "app/views/common/_user_navigation.html.erb" ,:after => "<%= render_list do |list|" do
    <<-CODE
    if #{@user_model_name.downcase}_signed_in?  
      list << link_to("Settings", edit_#{@user_model_name.downcase}_registration_path) 
      list << link_to("Logout", destroy_#{@user_model_name.downcase}_session_path)
    else
      list << link_to("Login", new_#{@user_model_name.downcase}_session_path)
      list << link_to("Signup", new_#{@user_model_name.downcase}_registration_path)
    end
    CODE
  end

  say <<-CODE
    還需要執行下列步驟：
    1. 設定database.yml
    2. 執行rake db:create
    3. 執行rake db:migrate
    4. 執行rake db:seeds
    CODE

end
