class Upload < ActiveRecord::Base
  # CATEGORIES = [
  #   ["ARC Documents",     "arc_documents"],
  #   ["Financial Reports", "financial_reports"],
  #   ["HOA Documents",     "hoa_documents"],
  #   ["Gazette",           "gazette"],
  #   ["Maintenance",       "maintenance"],
  #   ["Minutes",           "minutes"],
  #   ["Projects",          "projects"]
  # ]

  belongs_to :user

  validates :title,    presence: true, length: { minimum: 5, if: "title.present?" }
  # validates :category, presence: true, inclusion: { in: CATEGORIES.map(&:last), if: "category.present?" }
  validates :s3_url,   presence: true, uniqueness: true
  validates_associated :user
end
