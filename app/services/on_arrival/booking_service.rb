class OnArrival::BookingService
  attr_reader :slot, :params

  def initialize(params)
    @params = params
  end

  def call
    create_booking(params[:slot_id])
  end

  def create_booking(slot_id)
    # binding.pry
    slot = Slot.find_by(id: slot_id)
    if slot.status == "booked"
      error("Slot is not available")
    else
      booking = Booking.new
      booking.slot_id = slot_id
      booking.license_plate = params[:license_plate]
      #   booking.arrival_time = Time.zone.now
      #   booking.left_time = Time.zone.now
      booking.ref_code = SecureRandom.hex(3)
      if booking.save
        slot.update(status: "booked")
        success(booking)
      else
        error(booking.errors.full_messages.join(", "))
      end
    end
  end

  def success(booking)
    { success: true, message: "Booking created succefully ", booking: }
  end

  def error(message)
    { success: false, message: }
  end
end
