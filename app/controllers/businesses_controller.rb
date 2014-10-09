class BusinessesController < ApplicationController
  include FeedConcern

  layout "external_profile"
  def index
  end

  def show
    @post = Post.new
    #refactor this name
    @select = select_array
    business = Business.find(params[:id])
    @entity = business
    @default_entity = business
    @posts = build_sorted_posts(business.posts)

  end
end
