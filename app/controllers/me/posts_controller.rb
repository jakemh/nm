class Me::PostsController < MeController
  
  def index
  end

  def show
  end

  def new
    Post.new
  end

  def create

  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
  def whitelist(type)
    params.require(type.underscore).permit(:content)
  end
end
