require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:slot) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:license_plate) }
    it { is_expected.to validate_length_of(:license_plate).is_at_least(6).is_at_most(8) }
  end

  describe 'callbacks' do
    it 'set arrival_time to Time.now' do
      booking = create(:booking)
      expect(booking.arrival_time) == (Time.zone.now)
    end

    it 'set left_time to nil' do
      booking = create(:booking)
      expect(booking.left_time).to eq(nil)
    end
  end
end
