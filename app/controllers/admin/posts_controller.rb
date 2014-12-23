class Admin::PostsController <  Admin::AdminController

  def index
    @model = model_type
    @posts = Post.all.includes(:responses, :user, :business).where(type: [nil, "", "Post"]).sort_by{|e| e.id }.reverse
  end

  protected
    def model_type
      Post
    end

end


  