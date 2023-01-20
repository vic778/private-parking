class SlotType < ApplicationRecord
  belongs_to :parking
  has_many :slots
  SLOTTYPES_OPTIONS = %w[Motorcycle Car Truck per desabled_people].freeze

  validates :name, inclusion: { in: SLOTTYPES_OPTIONS }, presence: true, uniqueness: true
end
