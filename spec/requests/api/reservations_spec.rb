require 'rails_helper'
require './spec/support/sign_in'

RSpec.describe "Api::Reservations", type: :request do
  context "when as a customer" do
    before(:each) do
      @user = sign_in_customer
      @headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: "Bearer #{@user['token']}",
        uid: @user['email']
      }
    end

    # describe "Get all the reservations for the customer" do
    #   it "returns all the reservations" do
    #     reservation = create(:reservation, customer: @user)
    #     get '/api/reservations', headers: @headers
    #     expect(response.body).to eq([reservation].to_json)
    #   end
    # end
  end
end
