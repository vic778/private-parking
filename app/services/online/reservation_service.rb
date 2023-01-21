module Online
  class ReservationService
    attr_accessor :customer, :slot, :params

    def initialize(customer, slot)
      @customer = customer
      @slot = slot
    end

    def call
      customer = current_user
    end

    def reserve_slot(from, to)
      return error("This slot can not be booked because it's #{slot.status}") unless slot.status == "available"

      hours = (to.to_i - from.to_i) / 1.hour
      total_price = hours * slot.price
      reservation = customer.reservations.new(slot:, from:, to:, total_price:)
      reservation.slot_type = slot.slot_type.name
      #   binding.pry
      if reservation.save
        slot.update(status: "booked")
        success(reservation)
      else
        error(reservation.errors.full_messages.join(", "))
      end
    end

    def success(reservation)
      { success: true, message: "Reservation created successfully", reservation: }
    end

    def error(message)
      { success: false, message: }
    end
  end
end
