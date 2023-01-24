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

    describe "Get all the reservations for the customer" do
      it "returns all user's reservations" do
        customer = create(:user)
        slot = create(:slot, status: :available)
        user_reservations = create(:reservation, customer:, slot:)
        slots = customer.reservations.includes(:slot).map(&:slot)
        get '/api/customer_slots', headers: @headers
        response do
          # binding.pry
          data = JSON.parse(response.body)
          expect(data['slots']).to eq(slots)
        end
      end
    end
  end
end
