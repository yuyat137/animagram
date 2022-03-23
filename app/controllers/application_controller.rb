class ApplicationController < ActionController::Base
  before_action :require_login

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render404
  rescue_from ActionController::RoutingError, with: :render404
  rescue_from Exception, with: :render500

  def render404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: 'errors/error404', status: :not_found, layout: 'application'
  end

  def render500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: 'errors/error500', status: :internal_server_error, layout: 'application'
  end

  def require_login
    return if logged_in?

    redirect_to main_app.login_path, notice: t('defaults.require_login')
  end
end
