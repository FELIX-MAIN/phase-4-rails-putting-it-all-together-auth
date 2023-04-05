class ApplicationController < ActionController::API
  include ActionController::Cookies

  def require_login
    unless logged_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
end
