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
    # render json: entity.includes(:responses).posts.where(:id => params[:id].split(","), type: [nil, "", "Post"])
  end

  def create
  
    @post = entity.posts.build whitelist
    id_key = nil
    if @post.save
      json = PostSerializer.new(@post).to_json
      # byebug

      # if entity.class == User
      #   id_key = :user_id
      # elsif entity.class == business
      #   id_key = :business_id

      # end
      # render json: {
      #   :content => @post.content,
      #   id_key => entity.id

      # }
      render json: @post, serialzer: PostSerializer
    end
  end

  private
  def whitelist
    params.require(:post).permit(:content, :parent_id, :type, :entity_type)
  end

end
