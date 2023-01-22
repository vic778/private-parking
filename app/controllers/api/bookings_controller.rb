class Api::BookingsController < PermissionsController
  def create
    service = OnArrival::BookingService.new(params)
    result = service.call
    # binding.pry
    if result[:success]
      render json: { message: result[:message], booking: result[:booking] }, status: :ok
    else
      render json: { error: result[:message] }, status: :unprocessable_entity
    end
  end

  def check_in
    booking = Booking.find_by(ref_code: params[:ref_code])
    if booking
      p "Do you want to check in? (y/n)"
      user_response = gets.chomp
      if user_response == "y"
        booking.update(left_time: Time.zone.now, status: "checked", total_price: booking.slot.price)
        booking.slot.update(status: "available")
        render json: { message: "You have checked in successfully", booking: }, status: :ok
      else
        render json: { message: "You have not checked in" }, status: :ok
      end
    else
      render json: { error: "Booking not found" }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:arrival_time, :left_time, :total_price, :ref_code, :license_plate, :slot_id)
  end
end
