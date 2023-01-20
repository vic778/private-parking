class Slot < ApplicationRecord
  belongs_to :slot_type
  has_one :reservation
  has_one :booking

  validate :validate_slot_status

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

  # def update_slot_status
  #   if self.reservation.present?
  #     self.status = 1
  #   else
  #     self.status = 0
  #   end
  # end
end
