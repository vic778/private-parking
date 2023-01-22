require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:slot) }
    it { should belong_to(:customer).class_name('User').with_foreign_key('user_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_presence_of(:slot_type) }
    it { should validate_numericality_of(:number_of_hours).is_greater_than(0) }
  end

  describe 'invalidations' do
    it 'is invalid without a from' do
      reservation = FactoryBot.build(:reservation, from: nil)
      expect(reservation).to_not be_valid
      expect(reservation.errors[:from]).to include("can't be blank")
    end

    it 'is invalid without a to' do
      reservation = FactoryBot.build(:reservation, to: nil)
      expect(reservation).to_not be_valid
      expect(reservation.errors[:to]).to include("can't be blank")
    end

    it 'is invalid without a slot_type' do
      reservation = FactoryBot.build(:reservation, slot_type: nil)
      expect(reservation).to_not be_valid
      expect(reservation.errors[:slot_type]).to include("can't be blank")
    end

    it 'is invalid without a number_of_hours' do
      reservation = FactoryBot.build(:reservation, number_of_hours: nil)
      expect(reservation).to_not be_valid
      expect(reservation.errors[:number_of_hours]).to include("can't be blank")
    end

    it 'is invalid with a number_of_hours less than 0' do
      reservation = FactoryBot.build(:reservation, number_of_hours: -1)
      expect(reservation).to_not be_valid
      expect(reservation.errors[:number_of_hours]).to include('must be greater than 0')
    end
  end
end
