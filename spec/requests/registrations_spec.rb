require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  it "creates a new user" do
    get '/users/sign_up', params: { user: { email: 'test@gmail.com', name: 'hello', password: 'test123' }, confirmed_at: Time.now }, headers: @headers
    # binding.pry
    expect(response.body) == ("Thank you for joining Private PArking platform, please check your email and verify your account!")
  end
end
