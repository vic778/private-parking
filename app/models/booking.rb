require 'time'
class Booking < ApplicationRecord
  belongs_to :slot
  before_create :set_arrival_time, :set_left_time_to_nil

  validates :license_plate, presence: true, length: { minimum: 6, maximum: 8 }

  private

  def set_arrival_time
    self.arrival_time = Time.zone.now
  end

  def set_left_time_to_nil
    self.left_time = nil
  end
end
