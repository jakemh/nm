class BusinessesController < ApplicationController
  layout "external_profile_business"
  include FeedConcern
  include ProfileConcern

  def index
    @businesses = if params[:first_letter]
      Business.by_first_letter(params[:first_letter])
    else
      Business.random(3)
    end

    @h = Gmaps4rails.build_markers(@businesses) do |b, m|
      marker.lat b.locations.last.latitude
      marker.lng b.locations.last.longitude
    end
    respond_to do |format|
      format.html
      format.json {render json: @businesses}
    end
    # render json: @businesses
  end

  def show
    @message = Message.new
    @post = Post.new

    #refactor this name
    @select = select_array
    business = Business.find(params[:id])
    @entity = business
    @default_entity = business
    @posts = build_sorted_posts(business.posts.where(type: [nil, ""]))

  end
end
