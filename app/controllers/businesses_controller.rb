class BusinessesController < ApplicationController
  include FeedConcern

  layout "external_profile_business"

  def index
    @random_businesses = Business.where.not(:id => [User.first.connections.where(:type => ["BusinessConnection", "Ownership"]).pluck(:id)]).order("RANDOM()").limit(3)
  end

  def show
    @post = Post.new
    @message = Message.new

    #refactor this name
    @select = select_array
    business = Business.find(params[:id])
    @entity = business
    @default_entity = business
    @posts = build_sorted_posts(business.posts)

  end
end
