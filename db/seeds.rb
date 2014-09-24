roles = ["Admin", "User"]

roles.each do |role|
  Role.create(:name => role)
end