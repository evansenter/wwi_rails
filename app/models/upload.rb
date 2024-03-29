# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  category   :integer
#  s3_url     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  published  :boolean          default(FALSE)
#

class Upload < ActiveRecord::Base
  belongs_to :user

  default_scope { includes(:user) }
  scope :published_in_category, ->(id) { where(category: id, published: true).includes(:user).order("created_at DESC") }

  enum category: ["Water Policy", "Water Security", "Global Markets", "Capital Markets", "Other"]

  validates :title,    presence: true, length: { minimum: 5, if: "title.present?" }
  validates :category, inclusion: { in: categories.keys }
  validates :s3_url,   presence: true, uniqueness: true
  validates_associated :user

  paginates_per 10

  def self.categories_with_ids
    categories.keys.map { |readable| [readable, readable.remove(/\s+/).underscore] }
  end

  def readable_status
    published? ? "Published" : "Pending"
  end

  def created_at_readable
    created_at.strftime('%B %e at %l:%M%p')
  end
end
