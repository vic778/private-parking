class Role < ApplicationRecord
  has_many :users
  # has_many :customers, class_name: 'User', foreign_key: 'user_id'

  enum role: {
    user: 0,
    admin: 1
  }

  validates :name, presence: true, uniqueness: true
end
