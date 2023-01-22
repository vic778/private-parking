require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:role) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    describe 'after_initialize' do
      it 'sets default role to user' do
        user = FactoryBot.build(:user)
        expect(user.role.name) == 'user'
      end
    end

    describe 'teacher?' do
      it 'returns true if role is admin' do
        user = FactoryBot.build(:user, :admin)
        expect(user.is_admin?).to be true
      end

      it 'returns false if role is not user' do
        user = FactoryBot.build(:user, :user)
        expect(user.role.admin?).to be false
      end
    end

    describe 'update_role!' do
      it 'updates role_name' do
        user = FactoryBot.build(:user, :user)
        user.update_role!('admin')
        expect(user.role.name).to eq 'admin'
      end
    end

    describe 'requires_confirmation?' do
      it 'returns true if user is not confirmed' do
        user = FactoryBot.build(:user, :user)
        expect(user.requires_confirmation?).to be true
      end

      it 'returns false if user is confirmed' do
        user = FactoryBot.build(:user, :user)
        user.confirmed_at = Time.now
        expect(user.requires_confirmation?).to be false
      end
    end

    describe 'generate_jwt' do
      it 'returns a valid jwt' do
        user = FactoryBot.build(:user, :user)
        expect(user.generate_jwt).to be_truthy
      end
    end
  end
end
