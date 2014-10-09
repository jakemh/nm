class UsersController < ApplicationController
  layout "external_profile"  
  include FeedConcern

  def index
    @users = User.where("users.id != ?", current_user.id)
  end

  def show
    @post = Post.new
    #refactor this name
    @select = select_array
    user = User.find(params[:id])
    # @entity = user
    @default_entity = user
    @posts = build_sorted_posts(user.posts)

  end
end
