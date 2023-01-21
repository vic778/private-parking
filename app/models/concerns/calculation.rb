class Calculation
  attr_accessor :slot, :start_time

  def initialize(slot)
    @slot = slot
    @start_time = start_time
  end

  def duration_in_hours
    (slot.close_time - slot.open_time) / 1.hour
  end

  def include_time_range?(start_time)
    if duration_in_hours
      range = [1, 2, 3, 4, 5, 6]
      range.include?(start_time.to_i)
    else
      false
    end
  end
end
