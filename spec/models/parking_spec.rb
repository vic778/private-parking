require 'rails_helper'

RSpec.describe Parking, type: :model do
  describe 'associations' do
    it { should have_many(:slot_types) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:open_time) }
    it { should validate_presence_of(:close_time) }

    it 'uniqueness of the name' do
      parking = FactoryBot.create(:parking)
      parking2 = FactoryBot.build(:parking, name: parking.name)
      expect(parking2).to_not be_valid
      expect(parking2.errors[:name]).to include('has already been taken')
    end
  end

  describe 'invalidations' do
    it 'is invalid without a name' do
      parking = FactoryBot.build(:parking, name: nil)
      expect(parking).to_not be_valid
      expect(parking.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an address' do
      parking = FactoryBot.build(:parking, address: nil)
      expect(parking).to_not be_valid
      expect(parking.errors[:address]).to include("can't be blank")
    end

    it 'is invalid without an open_time' do
      parking = FactoryBot.build(:parking, open_time: nil)
      expect(parking).to_not be_valid
      expect(parking.errors[:open_time]).to include("can't be blank")
    end

    it 'is invalid without an close_time' do
      parking = FactoryBot.build(:parking, close_time: nil)
      expect(parking).to_not be_valid
      expect(parking.errors[:close_time]).to include("can't be blank")
    end
  end
end
