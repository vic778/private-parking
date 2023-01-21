class Api::SlotsController < PermissionsController
  before_action :authenticate_user!

  def index
    slots = scope_slots
    render json: slots
  end

  def search_slots
    slots = scope_slots
    available_slots = filter_slots_by_features(slots)
    render json: available_slots
  end

  def show
    slot = Slot.find_by(id: params[:id])
    if slot
      calculation = Calculation.new(slot)
    else
      render json: "[]"
    end
  end

  private

  def scope_slots
    Slot.where(status: :available)
  end

  def filter_slots_by_features(scope_slots)
    if params[:slot_type_id].present?
      scope_slots.joins(:slot_type).where(slot_type_id: params[:slot_type_id].to_i)
    elsif params[:price].present?
      scope_slots.where("price <= ?", params[:price].to_f)
    elsif params[:start_time].present?
      scope_slots.select do |slot|
        start_time = params[:start_time]
        #   end_time = params[:end_time]
        calculation = Calculation.new(slot)
        calculation.include_time_range?(start_time)
      end
    else
      scope_slots
    end
  end
end
