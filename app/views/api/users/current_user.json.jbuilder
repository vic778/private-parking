json.user do
  json.call(current_user, :id, :email, :name)
  json.role current_user.role.name
  json.token current_user.generate_jwt
end
