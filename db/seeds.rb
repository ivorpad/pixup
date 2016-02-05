['admin', 'member', 'banned'].each do |role|
  Role.find_or_create_by({ name: role })
end
