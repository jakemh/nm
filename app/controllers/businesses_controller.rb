class BusinessesController < ApplicationController
  layout "profile"
  include FeedConcern
  include ProfileConcern

  def index
    @businesses = if params[:first_letter]
      Business.by_first_letter(params[:first_letter])
    else
      Business.random(current_user, 3)
    end
    
    # respond_to do |format|
      # format.html
    render json: @businesses
    # end
    # render json: @businesses
  end

  def show
    @distance = params[:distance]

    respond_to do |format|
      format.html do 
        @message = Message.new
        @post = Post.new

        #refactor this name
        @select = select_array
        business = Business.find(params[:id])
        @entity = business
        @default_entity = business
        @posts = build_sorted_posts(business.posts.where(type: [nil, ""]))
      end
      format.json do 
        ids = params[:id].split(",")
        @businesses = if ids.length == 1
          # current_user.businesses.find(params[:id].split(","))
          Business.find(ids[0])
        elsif ids.length > 1
          Business.find(ids)
        else current_user.businesses
        end

        render json: @businesses
      end
    end

  end
end
