module Api
  class ReservationsController < PermissionsController
    before_action :authenticate_user!
    before_action :set_reservation, only: %i[show update cancel]

    def index
      reservations = current_user.reservations
      render json: reservations
    end

    def show
      render json: @reservation
    end

    def customer_slots
      slots = current_user.reservations.includes(:slot).map(&:slot)
      render json: slots
    end

    def create
      slot = Slot.find_by(id: params[:slot_id])
      from = params[:from]
      to = params[:to]
      service = Online::ReservationService.new(current_user, slot)
      result = service.reserve_slot(from, to)
      if result[:success]
        render json: { message: result[:message], reservation: result[:reservation] }, status: :created
      else
        render json: { error: result[:message] }, status: :unprocessable_entity
      end
    end

    def update
      if @reservation.update(reservation_params)
        render json: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end

    def cancel
      reservation = Reservation.find(params[:id])
      service = Online::ReservationService.new(current_user, reservation.slot)
      result = service.cancel_reservation(reservation)
      # binding.pry
      if result[:success]
        render json: { message: result[:message], reservation: result[:reservation] }, status: :ok
      else
        render json: { error: result[:message] }, status: :unprocessable_entity
      end
    end

    private

    def set_reservation
      @reservation = current_user.reservations.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:from, :to, :total_price, :slot_id)
    end
  end
end
