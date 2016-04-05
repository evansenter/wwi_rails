class AdminController < ApplicationController
  before_filter :require_admin!

  def manage_users
    @users = User.order("created_at DESC").page(params[:page]).includes(:contact_info)
  end

  def set_user_role
    @user = User.find(params[:user_id])

    if @user && @user != current_user && ContactInfo::ROLES.include?(params[:role])
      @user.update_attribute(:role, params[:role])
      flash.notice = "%s now has the role '%s'." % [@user.email, @user.role.capitalize]
    else
      flash.alert = "HAL: I'm sorry, Dave. I'm afraid I can't do that."
    end

    redirect_to :manage_users
  end
end
