class ApplicationController < ActionController::Base
  helper_method :user_logged_in?
  def remember(user)
    user.token_encrypt
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.token
  end

  def current_user
    if (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      @current_user = user
    end
  end
 
  def forget_session(user)
    user.delete_session_token
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logout
    forget_session(current_user)
    @current_user = nil
  end

  def user_logged_in?
    !current_user.nil?
  end

  def logged_in_user
    redirect_to login_path unless user_logged_in?
  end
end
