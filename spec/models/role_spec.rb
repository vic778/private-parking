require 'rails_helper'

RSpec.describe Role, type: :model do
  it { is_expected.to have_many(:users) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'enum' do
    it { is_expected.to define_enum_for(:name).with_values(user: 0, admin: 1) }
  end

  describe 'after_initialize' do
    it 'sets default role to user' do
      role = FactoryBot.build(:role)
      expect(role.name) == 'user'
    end
  end

  describe 'admin' do
    it 'returns true if role is admin' do
      role = FactoryBot.build(:role, :admin)
      expect(role.admin?).to be true
    end

    it 'returns false if role is not admin' do
      role = FactoryBot.build(:role, :user)
      expect(role.admin?).to be false
    end
  end
end
