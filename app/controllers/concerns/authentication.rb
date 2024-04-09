module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :logged_in?
  end

  private

  def authenticate_user!
    return if logged_in?

    redirect_to login_path
  end

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    Current.user ||= User.find_by(id: session[:user_id])
  end
end
