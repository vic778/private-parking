module Online
  class ReservationService
    attr_accessor :customer, :slot

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

    def cancel_reservation(reservation)
      now = Time.zone.now
      time_passed = (Time.zone.now - reservation.created_at) / 60
      # binding.pry
      if time_passed > 1800 # 1800 seconds = 30 min
        error("Reservation can not be canceled because it was created more than 30 minutes ago")
      elsif time_passed > 300 # 300 seconds = 5 min
        cancel_without_charge(reservation)
      elsif time_passed < 900 # 900 seconds = 15 min
        cancel_with_charge(reservation, 0.02)
      elsif time_passed < 1500 # 1500 seconds = 25 min
        cancel_with_charge(reservation, 0.1)
      else
        error("Reservation can not be canceled because it was created more than 25 minutes ago")
      end
    end

    def cancel_without_charge(reservation)
      reservation.update(cancelled_at: Time.now, status: "cancelled")
      slot.update(status: "available")
      success(reservation)
    end

    def cancel_with_charge(reservation, charge_percentage)
      # binding.pry
      charge = (reservation.total_price.to_f * charge_percentage).round(2)
      reservation.update(cancelled_at: Time.zone.now, status: "cancelled", cancellation_charge: charge)
      slot.update(status: "available")
      success(reservation)
    end

    def success(reservation)
      { success: true, message: "Reservation created successfully", reservation: }
    end

    def error(message)
      { success: false, message: }
    end
  end
end
