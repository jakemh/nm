class PostPointsController < PointsController

  def create
    post = Post.find(params[:post_id])
    point = post.points.build whitelist
    owned_entity_last_votes = current_user.all_owned.inject([]){|list, entity| list << entity.last_vote_for(post); list}.compact
    
    if PostPoint.validate_time_frame(owned_entity_last_votes)
      if point.save
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
