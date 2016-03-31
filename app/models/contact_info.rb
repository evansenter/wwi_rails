class ContactInfo < ActiveRecord::Base
  ROLES = %i[unregistered registered verified admin]

  belongs_to :user

  enum role: ROLES

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    [first_name, last_name].join(" ")
  end
end
