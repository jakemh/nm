class Admin::Alerts::AlertsController < Admin::AdminController
  skip_load_and_authorize_resource
  layout "admin_alerts"

  DEFAULT_POST_THRESHOLD = -10

  def index
    super
    @all_posts = Post.all.includes(:responses, :user, :business).where(type: [nil, "", "Post"]).sort_by{|e| e.send(sort) || ""}
    @rejected_posts = @all_posts.reject{|p| p.total_points > (DEFAULT_POST_THRESHOLD || params[:threshold])}
    @rejected_post_count = @rejected_posts.count

    @all_users = User.all
    @rejected_user_count = 0

    @notifications = [ @rejected_post_count,  @rejected_user_count].sum
  end

  def show
    redirect_to [:admin, :alerts, :points, :posts, {reverse: false, sort: :total_points}] 
  end


end
