class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def user_not_authorized
    flash[:warning] = %Q[Only logged in users can perform this action. <a href='#{url_for(new_user_registration_path)}'> Register here </a>.]
    redirect_to(request.referrer || root_path)
  end

  def register_url
    new_user_registration_path
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.is_admin?
      flash[:warning] = "This area is restricted to administrators only."
      redirect_to root_path
    end
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.is_admin?
    current_user
  end

# TODO: DRY
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :company
  end
end
