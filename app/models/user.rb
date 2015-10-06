class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  after_create :subscribe_user_to_mailing_list

  has_one :contact_info
  has_many :posts

  accepts_nested_attributes_for :contact_info

  validates_associated :contact_info, message: "is not complete"

  delegate :full_name, :role, *ContactInfo::ROLES.product(%w[? !]).map(&:join), to: :contact_info

  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.new.async.perform(self)
  end
end
