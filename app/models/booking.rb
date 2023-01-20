require 'time'
class Booking < ApplicationRecord
  belongs_to :slot
  before_create :set_arrival_time, :set_left_time_to_nil

  private

  def set_arrival_time
    self.arrival_time = Time.now
  end

  def set_left_time_to_nil
    self.left_time = nil
  end
end
