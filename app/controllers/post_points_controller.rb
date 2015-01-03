class PostPointsController < PointsController
  VALIDATE_TIME_FRAME = true

  def create

    post = Post.find(params[:post_id])
    point = post.points.build whitelist
    if point.valid_vote?(post, entity_condition(current_user))
    # if !VALIDATE_TIME_FRAME || PostPoint.validate_time_frame(current_user.owned_entity_last_votes(post))
    # if PostPoint.already_voted?(current_user.owned_entity_last_votes(post))
      if point.save!
        render json: point
      else render json: {:error => "Could not save"}
      end
    else render json: {:error => "Already posted!"}
    end
  end

  protected
    def whitelist
      super.merge({:type => params[:type]})
    end
end
