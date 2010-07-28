Given /^a user with the login "([^"]*)" exists$/ do |login|
  user = User.create do |u|
    u.password = u.password_confirmation = "simpson312"
    u.login = login
    u.email = "homersimpson@test.com"
  end
  user.save
end
