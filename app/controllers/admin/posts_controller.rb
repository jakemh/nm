class Admin::PostsController <  Admin::AdminController

  def index
    super(type: [nil, "", "Post"])

    # @model = model_type
    # @posts = Post.all.includes(:responses, :user, :business).where(type: [nil, "", "Post"])
    # # @posts = @posts.sort{ |a,b| a.send(sort) <=> b.send(sort)}
    # @posts = @posts.sort_by{ |p| p.send(sort) ||  "  "}

    # @posts = @posts.reverse! if reverse
    # redirect_to admin_posts_path(:fuck => "YES")
  end

  protected
    def model_type
      Post
    end

end


  