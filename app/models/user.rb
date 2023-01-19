class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  belongs_to :role
  after_initialize :set_default_role

  validates :name, presence: true

  def is_admin?
    role.name == 'admin'
  end

  def has_permission?(action, resource)
    if !!role
      role.has_permission?(action, resource)
    else
      false
    end
  end

  def update_role!(role_name)
    self.role = Role.find_or_create_by(name: role_name)
    save!
  end

  private

  def set_default_role
    self.role = Role.find_or_create_by(name: 'user') if role.nil?
  end
end
