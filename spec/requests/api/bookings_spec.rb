require 'rails_helper'

RSpec.describe "Api::Bookings", type: :request do
  describe "Create a booking" do
    it "creates a booking" do
      slot = create(:slot, status: :available)
      params = { slot_id: slot.id, license_plate: "ABC123" }
      service = OnArrival::BookingService.new(params)
      result = service.call

      expect(result[:success]).to eq(true)
      expect(result[:message]) == ("Booking created successfully")
      expect(slot.reload.status).to eq("booked")
      expect(Booking.last.slot_id).to eq(slot.id)
      expect(Booking.last.license_plate).to eq("ABC123")
    end
  end

  describe "Check in" do
    it "checks in" do
      slot = create(:slot, status: :available)
      booking = create(:booking, slot:)
      params = { ref_code: booking.ref_code }
      if params[:ref_code] == booking.ref_code
        p "Do you want to check in? (y/n)"
        user_response = gets.chomp
        if user_response == "y"
          booking.update(left_time: Time.zone.now, status: "checked", total_price: booking.slot.price)
          booking.slot.update(status: "available")

          expect(result[:success]).to eq(true)
          expect(result[:message]) == ("You have checked in successfully")
          expect(booking.reload.status).to eq("checked")
          expect(booking.reload.left_time).to be_present
          expect(booking.reload.total_price).to eq(booking.slot.price)
          expect(slot.reload.status).to eq("available")
        end
      end
    end
  end
end
