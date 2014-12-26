class PostPointsController < PointsController

  def create
    post = Post.find(params[:post_id])
    point = post.points.build whitelist
    if point.save
      render json: post
    end
  end

  protected

end
