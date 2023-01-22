require 'rails_helper'

RSpec.describe Slot, type: :model do
  describe 'associations' do
    it { should belong_to(:slot_type) }
    it { should have_one(:reservation) }
    it { should have_one(:booking) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:open_time) }
    it { should validate_presence_of(:close_time) }
    it { should validate_presence_of(:status) }
  end

  describe 'invalidations' do
    it 'is invalid without a name' do
      slot = FactoryBot.build(:slot, name: nil)
      expect(slot).to_not be_valid
      expect(slot.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a price' do
      slot = FactoryBot.build(:slot, price: nil)
      expect(slot).to_not be_valid
      expect(slot.errors[:price]).to include("can't be blank")
    end

    it 'is invalid without an open_time' do
      slot = FactoryBot.build(:slot, open_time: nil)
      expect(slot).to_not be_valid
      expect(slot.errors[:open_time]).to include("can't be blank")
    end

    it 'is invalid without an close_time' do
      slot = FactoryBot.build(:slot, close_time: nil)
      expect(slot).to_not be_valid
      expect(slot.errors[:close_time]).to include("can't be blank")
    end

    it 'is invalid without an status' do
      slot = FactoryBot.build(:slot, status: nil)
      expect(slot).to_not be_valid
      expect(slot.errors[:status]).to include("can't be blank")
    end
  end
end
