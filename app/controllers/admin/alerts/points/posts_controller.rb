class Admin::Alerts::Points::PostsController < Admin::Alerts::AlertsController  
  DEFAULT_THRESHOLD = -10
  # layout "admin_alerts"

  def index
    # super
    super
    # @rejected = @posts.reject{|p| p.total_points > (DEFAULT_THRESHOLD || params[:threshold])}
    # @rejected_post_count = @rejected.count
  end

 
  protected
    def model_type
      Post
    end
  
end
