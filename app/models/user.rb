class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :subscribe_user_to_mailing_list

  has_one :contact_info

  accepts_nested_attributes_for :contact_info

  validates_associated :contact_info, message: "is not complete"

  delegate :full_name, to: :contact_info

  def username
    full_name
  end

  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.new.async.perform(self)
  end
end
