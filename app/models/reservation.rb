class Reservation < ApplicationRecord
  belongs_to :slot
  belongs_to :customer, class_name: 'User', foreign_key: 'user_id'

  validates :from, :to, presence: true # format: { with: /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}\z/, message: 'must be in the format YYYY-MM-DDTHH:MM' }
  validates :number_of_hours, numericality: { greater_than: 0 }, if: :number_of_hours?
  validate :from_is_before_to, :from_is_in_future
  validates :slot_type, presence: true

  def from_is_before_to
    return if from.blank? || to.blank?

    # binding.pry

    errors.add(:to, 'must be greather than from') if to <= from
  end

  def from_is_in_future
    return if from.blank?

    errors.add(:from, 'must be etheir now or in the futur ') if from < Time.now
  end
end
