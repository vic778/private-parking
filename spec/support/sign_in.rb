def sign_in_admin
  role = create(:role, name: "admin")
  user = create(:user, :with_confirmed_email, role:)
  post '/api/login', params: { user: { email: user.email, password: user.password } }
  res = JSON.parse(response.body)
  res["user"]
end

def sign_in_customer
  user = create(:user, :with_confirmed_email)
  post '/api/login', params: { user: { email: user.email, password: user.password } }
  res = JSON.parse(response.body)
  res["user"]
end
