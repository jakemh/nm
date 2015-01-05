class FollowingSerializer < ConnectionSerializer
  
  def interactions_in
    @interactions_out
  end

end
