# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text(65535)
#  published  :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { minimum: 10 }
  validates :body, presence: true, uniqueness: true, length: { minimum: 10 }
  validates_associated :user

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
