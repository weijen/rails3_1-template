rubies = ["1. MRI 1.8.7","2. MRI 1.9.2","3. REE","4. JRuby"]
rubies_option = rubies.join("\n")
user_select = ask("What rubies you use?\n#{rubies_option}\n")
@ruby_version =  case user_select
when "1"
    "ruby-1.8.7"
when "2"
    "ruby-1.9.2"
when "3"
    "ree"
when "4"
    "JRuby"
else
    "ruby-1.8.7"
end

template( (File.dirname(__FILE__) + '/templates/rvmrc.tt'), ".rvmrc")
