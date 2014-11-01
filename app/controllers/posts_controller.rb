class PostsController < ApplicationController
  include FeedConcern

  def index
    @posts = 
      if display_all_posts && params[:all]
        Post.all.where(type: [nil, "", "Post"])
      else entity.posts.where(type: [nil, "", "Post"])
      end

    render json: @posts
  end

  def show
    render json: entity.posts.where(:id => params[:id].split(","), type: [nil, "", "Post"])
  end

  def create
  
    @post = entity.posts.build whitelist

    if @post.save
      render json: @post
    end
  end

  private
  def whitelist
    params.require(:post).permit(:content, :parent_id, :type, :entity_type)
  end

end
