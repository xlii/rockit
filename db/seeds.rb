['open', 'closed', "won't fix"].each do |name|
  Resolution.create! :name => name
end

AdminUser.reset_column_information
puts "Criando admin default..."
r = AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
puts "success" if r


