class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter { gon.current_tab = controller_name }
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << {
      contact_info_attributes: [
        :first_name,
        :last_name,
        :job_role,
        :institution
      ]
    }
  end

  def require_authorized_user!
    unless user_signed_in? && (current_user.authorized? || current_user.admin?)
      flash.alert = "Your account must be authorized before doing that."
      redirect_to :back
    end
  end

  def require_admin!
    unless user_signed_in? && current_user.admin?
      flash.alert = "You do not have privilidges to do that."
      redirect_to :back
    end
  end
end
