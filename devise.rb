generate 'devise:install'
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

  rake "db:migrate"
  rake "db:seed"
end
