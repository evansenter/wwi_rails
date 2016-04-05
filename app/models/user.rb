# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # after_create :subscribe_user_to_mailing_list

  has_one :contact_info
  has_many :posts
  has_many :uploads

  default_scope { includes(:contact_info) }

  accepts_nested_attributes_for :contact_info

  validates_associated :contact_info, message: "is not complete"

  paginates_per 10

  delegate :full_name, :role, :readable_role, *ContactInfo.roles.keys.product(%w[? !]).map(&:join), to: :contact_info

  private

  # def subscribe_user_to_mailing_list
  #   SubscribeUserToMailingListJob.new.async.perform(self)
  # end
end
