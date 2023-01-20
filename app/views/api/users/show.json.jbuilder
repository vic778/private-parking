json.user do |json|
  json.partial! 'api/users/user', user: current_user
end
