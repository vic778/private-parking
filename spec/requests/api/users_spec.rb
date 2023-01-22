require 'rails_helper'
require './spec/support/sign_in'

RSpec.describe "Api::Users", type: :request do
  context "when as a teacher" do
    before(:each) do
      @user = sign_in_customer
      @headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: "Bearer #{@user['token']}",
        uid: @user['email']
      }
    end

    it "updates user" do
      put '/api/user', params: { user: { email: 'test@gmail.com', name: 'hello', password: 'test123' } }.to_json, headers: @headers
      expect(response.body) == ({ user: @user['user'] }.to_json)
    end
  end
end
