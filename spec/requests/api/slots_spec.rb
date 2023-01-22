require 'rails_helper'
require './spec/support/sign_in'

RSpec.describe "Api::Slots", type: :request do
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

    describe "Get all the available slots" do
      it "returns all the slots" do
        get '/api/slots', headers: @headers
        expect(response.body).to eq(Slot.where(status: :available).to_json)
      end
    end

    describe "Get all the an available slot" do
      it "returns all the slots" do
        slot = create(:slot, status: :available)
        # binding.pry
        get "/api/slots/#{slot.id}", headers: @headers
        expect(response.body).to eq(Slot.find_by(id: slot.id).to_json)
      end
    end

    describe "Search slots features" do
      it "returns all the slots" do
        slot_type = create(:slot_type)
        slot = create(:slot, status: :available, slot_type:)
        get "/api/search_slots?slot_type_id=#{slot_type.id}", headers: @headers
        expect(response.body).to eq([slot].to_json)
      end

      it "returns all the slots" do
        slot = create(:slot, status: :available, price: 10)
        get "/api/search_slots?price=10", headers: @headers
        expect(response.body).to eq([slot].to_json)
      end
      it "returns all the slots" do
        slot = create(:slot, status: :available)
        calculation = Calculation.new(slot)
        start_time = Time.now + 1.hour
        end_time = start_time + 1.hour
        get "/api/search_slots?start_time=#{start_time}&end_time=#{end_time}", headers: @headers
        expect(response.body) == ([slot].to_json)
      end
    end
  end
end
