require 'sidekiq-scheduler'

class CancelExpiredReservationsWorker
  include Sidekiq::Worker

  def perform
    expired_reservations = Reservation.where("to < ?", Time.zone.now)
    expired_reservations.update_all(status: "available")
    #     reservation.update(status: "cancelled")
    #     reservation.slot.update(status: "available")
    #   end
  end
end
