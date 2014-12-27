class Admin::Alerts::Points::PostsController < Admin::Alerts::AlertsController  
  DEFAULT_THRESHOLD = -10
  # layout "admin_alerts"

  def index
    super
    @posts = @posts.reject{|p| p.total_points > (DEFAULT_THRESHOLD || params[:threshold])}
  end

  def self.controller_path
    "admin/posts"
  end

  protected
    def model_type
      Post
    end
  
end
