require 'rails_helper'

RSpec.describe SlotType, type: :model do
  describe 'associations' do
    it { should belong_to(:parking) }
    it { should have_many(:slots) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'invalidations' do
    it 'is invalid without a name' do
      slot_type = FactoryBot.build(:slot_type, name: nil)
      expect(slot_type).to_not be_valid
      expect(slot_type.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a parking' do
      slot_type = FactoryBot.build(:slot_type, parking: nil)
      expect(slot_type).to_not be_valid
      expect(slot_type.errors[:parking]).to include("must exist")
    end
  end

  describe 'uniqueness' do
    it 'is invalid with a duplicate name' do
      slot_type = FactoryBot.create(:slot_type)
      slot_type2 = FactoryBot.build(:slot_type, name: slot_type.name)
      expect(slot_type2).to_not be_valid
      expect(slot_type2.errors[:name]).to include('has already been taken')
    end
  end
end
