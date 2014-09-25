class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate

  # check_authorization :unless => :devise_controller?
  # check_authorization :unless => :temporary_controller?

  protected
    def authenticate
      if !current_user
        authenticate_or_request_with_http_basic do |username, password|
          username == "mvp" && password == "nextmission"
        end
      end
    end

  def redirect_to_back(default = root_url)
      if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
      else
        redirect_to default
      end
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActionController::RoutingError do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def render_404()
    redirect_to root_url, :alert => "Sorry! Page does not exist"
  end
end
