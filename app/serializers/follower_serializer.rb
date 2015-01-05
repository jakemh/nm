class FollowerSerializer < ConnectionSerializer

  attributes :interactions_in
  
  def interactions_in
    @interactions_out
  end
end
