class Role < ApplicationRecord
  has_many :users

  PERMISSIONS = {
    'admin' => {
      all: {
        index: true,
        show: true,
        create: true,
        update: true,
        destroy: true
      }
    },
    'user' => {
      parking: {
        index: true,
        show: true,
        create: true,
        update: true,
        destroy: true
      },
      slot: {
        index: true,
        show: true,
        create: true,
        update: true,
        destroy: true
      }
    }
  }.freeze

  enum name: {
    user: 0,
    admin: 1
  }

  def has_permission?(action, resource)
    PERMISSIONS.dig(name, resource, action) ||
      PERMISSIONS.dig(name, :all, action)
  end

  validates :name, presence: true, uniqueness: true
end
