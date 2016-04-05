# == Schema Information
#
# Table name: contact_infos
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :integer          default(0)
#  job_role    :integer
#  institution :string(255)
#

class ContactInfo < ActiveRecord::Base
  belongs_to :user

  enum role: %w[unauthorized authorized admin]
  enum job_role: %w[Student Faculty Industry Other]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, inclusion: { in: roles.keys }
  validates :job_role, inclusion: { in: job_roles.keys }
  validates :institution, presence: true

  def full_name
    [first_name, last_name].join(" ")
  end

  def readable_role
    {
      "unauthorized" => "Read only",
      "authorized"   => "Read and write",
      "admin"        => "Administrator"
    }[role]
  end
end
