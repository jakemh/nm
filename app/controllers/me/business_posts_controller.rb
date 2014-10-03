class Me::BusinessPostsController < Me::PostsController
  # def create
  #   @post = current_user.businesses.find(params[:business_id]).posts.build whitelist("BusinessPost")

  #   if @post.save
  #     redirect_to :back
  #   end
  # end

  private
  def entity
    id = type_array[1]
    current_user.businesses.find(id)

  end

end
