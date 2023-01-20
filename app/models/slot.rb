class Slot < ApplicationRecord
  belongs_to :slot_type
  has_one :reservation

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  validates :status, presence: true

  enum status: {
    available: 0,
    booked: 1,
    closed: 2
  }

end
