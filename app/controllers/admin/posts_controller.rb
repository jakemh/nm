class Admin::PostsController <  Admin::AdminController
  def index
    @posts = Post.all.includes(:responses, :user, :business).where(type: [nil, "", "Post"])

    # @posts = Post.all
  end

  def show

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
        flash[:notice] = "Post was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        redirect_to_back
    end
  end
end


  