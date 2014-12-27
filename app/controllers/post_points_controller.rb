class PostPointsController < PointsController
  VALIDATE_TIME_FRAME = true

  def create
    post = Post.find(params[:post_id])
    point = post.points.build whitelist
    if !VALIDATE_TIME_FRAME || PostPoint.validate_time_frame(current_user.owned_entity_last_votes(post))
      if point.save!
        render json: post
      end
    else render json: {:error => "Already posted in time frame"}
    end
  end

  protected
    def whitelist
      super.merge({:type => params[:type]})
    end
end
