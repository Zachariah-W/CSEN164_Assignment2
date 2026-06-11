class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?, :current_cart

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def current_cart
    sid = session[:cart_session_id]
    if sid.blank?
      sid = SecureRandom.hex(16)
      session[:cart_session_id] = sid
    end
    @current_cart ||= Cart.find_or_create_by!(session_id: sid)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Please log in first."
      redirect_to login_path
    end
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Admin access only."
      redirect_to root_path
    end
  end
end
