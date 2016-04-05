class AdminController < ApplicationController
  before_filter :require_admin!

  def manage_site
    @users = User.order("created_at DESC").page(params[:page])
    @uploads = Upload.order("created_at DESC").page(params[:page]).includes(:user)
  end

  def set_upload_status
    @upload = Upload.find(params[:upload_id])

    if @upload && %w(true false).include?(params[:status])
      @upload.update_attribute(:published, params[:status])
      flash.notice = "The article is now set as '%s'." % @upload.readable_status
    else
      notify_general_error
    end

    redirect_to manage_path
  end

  def set_user_role
    @user = User.find(params[:user_id])

    if @user && @user != current_user && ContactInfo.roles.keys.include?(params[:role])
      @user.contact_info.update_attribute(:role, params[:role])
      flash.notice = "%s now has the role '%s'." % [@user.email, @user.readable_role]
    else
      notify_general_error
    end

    redirect_to manage_path
  end

  private

  def notify_general_error
    flash.alert = "HAL: I'm sorry, Dave. I'm afraid I can't do that."
  end
end
