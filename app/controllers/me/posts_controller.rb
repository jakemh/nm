class Me::PostsController < MeController
  include ActionController::Live
  include FeedConcern

  # def index
  # end

  # def show
  # end

  def index
    # render json: build_sorted_posts(Post.all.where(type: [nil, ""]))
    render json: Post.all.where(type: [nil, ""])
  end

  def show
    render json: Post.where(:id => params[:id].split(","), type: [nil, ""])
  end
  

  def new
    @entity = entity
    @post = Post.new
  end

  def create
    @user = current_user
    @entity = entity
    # @post = default_entity.posts.build whitelist
    @post = entity.posts.build whitelist

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
  # def default_entity

  #   entity || current_user
  # end

  def entity
    type = type_array[0]
    id = type_array[1]
    if type == "Business"
      return current_user.businesses.find(id)
    else return current_user
    end
  end

  private
  def whitelist
    params.require(:post).permit(:content, :parent_id, :type)
  end

  def type_array
    JSON.parse(params.permit(:type_array)[:type_array])
  end
end
