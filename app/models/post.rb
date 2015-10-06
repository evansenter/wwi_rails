class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { minimum: 10 }
  validates :body, presence: true, uniqueness: true, length: { minimum: 10 }
  validates_associated :user

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
