# == Schema Information
#
# Table name: contact_infos
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer          default("0")
#

class ContactInfo < ActiveRecord::Base
  ROLES = %i[unauthorized authorized admin]

  belongs_to :user

  enum role: ROLES

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    [first_name, last_name].join(" ")
  end
end
