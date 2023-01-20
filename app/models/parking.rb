class Parking < ApplicationRecord
  has_many :slot_types

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true
end
