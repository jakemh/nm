class Me::PostsController < MeController
  
  def index
  end

  def show
  end

  def new
    @entity = entity
    @post = Post.new
  end

  def create
    @user = current_user
    @entity = entity
    p "XXXDEFAULTXXX: ", default_entity

    @post = default_entity.posts.build whitelist

    if @post.save
      redirect_to :back
    end
  end
  # def create
  #   @user = current_user

  #   redirect_to :back
  # end

  def update
  end

  def edit
  end

  def destroy
  end
  #override
  protected
  def default_entity

    entity || current_user
  end

  def entity

    nil
  end

  private
  def whitelist
    params.require(:post).permit(:content)
  end

  def type_array
    JSON.parse(params.permit(:type_array)[:type_array])
  end
end
