class PostsController < ApplicationController
  include FeedConcern

  def index
    render json: Post.all.where(type: [nil, ""])
    # render json: build_sorted_posts(Post.all.where(type: [nil, ""]))
  end

  def show
    render json: Post.find(params[:id])
  end
end
