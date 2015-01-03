class PostsController < ApplicationController
  include FeedConcern

  def index
    @posts = 
      if display_all_posts && params.has_key?("all")
        Post.all.includes(:responses, :user, :business).where(type: [nil, "", "Post"])
      else entity.posts.includes(:responses, :user, :business).where(type: [nil, "", "Post"])
      end

    render json: @posts
  end

  def show
    render json: parse_show_array(Post).sort_by{|p| p.id}
  end

  def create
  
    @post = entity.posts.build whitelist
    id_key = nil
    if @post.save
      # json = PostSerializer.new(@post).to_json
      render json: @post, serialzer: PostSerializer
    end
  end

  private
  def whitelist
    params.require(:post).permit(:content, :parent_id, :type, :entity_type)
  end

end
