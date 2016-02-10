user = User.create! :name => 'Ivor Padilla', :email => 'example@gmail.com', :password => '12345678', :password_confirmation => '12345678', :company => 'envato'

puts "User #{user.name} created"
