module ApplicationHelper
  def authorized_user_signed_in?
    user_signed_in? && current_user.authorized?
  end

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end
end
