class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    return if logged_in?

    redirect_to login_path, notice: t('defaults.require_login')
  end
end
