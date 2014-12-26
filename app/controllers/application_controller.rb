class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate 
  after_filter :track_action
  serialization_scope :view_context
  before_filter :authenticate_user!

  # attr_accessor :entity

  # check_authorization :unless => :devise_controller?
  # check_authorization :unless => :temporary_controller?
  def entity
    # @entity ||= set_entity
    set_entity
  end

  protected
 
  def parse_show_array(model)

    models = []
    ids = params[:id].split(",")
    @models =  model.find(ids)
    # @models = if ids.length == 1
    #   # current_user.businesses.find(params[:id].split(","))
    #   model.find(ids[0])
    # elsif ids.length > 1
    #   models = model.find(ids)
    # end
    

    return @models
  end
  
    def display_all_posts
      true
    end


   def track_action
     # ahoy.track "Processed #{controller_name}##{action_name}", request.filtered_parameters
   end
   
    def authenticate
      if !current_user
        authenticate_or_request_with_http_basic do |username, password|
          username == "mvp" && password == "nextmission"
        end
      end

      true
    end

    def all_owned
      current_user + current_user.businesses
    end

    def user_or_belongs_to_user
      return true if entity == current_user 
      return true if current_user.businesses.include? entity
      return false
    end

    def authenticate_entity
      if user_or_belongs_to_user
        return true
      else
        raise CanCan::AccessDenied
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
    if Rails.env.production?
      redirect_to root_url, :alert => exception.message
    end
  end

  # rescue_from Exception do |exception|
  #   if Rails.env.production?
  #     redirect_to root_url, :alert => "SORRY! Something went wrong"
  #   else
  #     byebug
  #   end
  # end

  def render_404()
    if Rails.env.production?
      redirect_to root_url, :alert => "Sorry! Page does not exist"
    end
  end

  def set_entity
    p "SET ENTITY"
   if params[:business_id]
      p params[:business_id]
     return Business.find(params[:business_id])
     p "ENTITY: ", @entity
   elsif params[:user_id]
     return  User.find(params[:user_id]) 
    else raise "Applicable entity not found!"

    end
  end
  # def after_sign_in_path_for(resource)
  #    redirect_to
  #  end
end
