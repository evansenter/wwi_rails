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
#  role       :integer          default(0)
#

class ContactInfo < ActiveRecord::Base
  belongs_to :user

  enum role: %i[unauthorized authorized admin]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, inclusion: { in: roles.keys }

  def full_name
    [first_name, last_name].join(" ")
  end
end
