# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  category   :string(255)
#  s3_url     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Upload < ActiveRecord::Base
  CATEGORIES = [
    ["Water Policy",    "water_policy"],
    ["Water Security",  "water_security"],
    ["Global Markets",  "global_markets"],
    ["Capital Markets", "capital_markets"],
    ["Other",           "other"],
  ]

  belongs_to :user

  validates :title,    presence: true, length: { minimum: 5, if: "title.present?" }
  validates :category, presence: true, inclusion: { in: CATEGORIES.map(&:last), if: "category.present?" }
  validates :s3_url,   presence: true, uniqueness: true
  validates_associated :user
end
