class BusinessesController < ApplicationController
  layout "profile"
  include FeedConcern
  include ProfileConcern

  def index
    @businesses = if params[:first_letter]
      Business.by_first_letter(params[:first_letter])
    elsif params[:random]
      Business.random(current_user, 3)
    else Business.all
    end
    
    # respond_to do |format|
      # format.html
    render json: @businesses
    # end
    # render json: @businesses
  end

  def update
    whitelist.delete_if { |key, value| value.blank? }
    name_hash = {}
    tags = params.permit(tags: [:name])["tags"]
    entity.update_attributes(whitelist)
    entity.tags.destroy_all
    # entity.skills.build(params.permit(skills: [:name]))
    entity.tags.build(tags)
    entity.save
    render json: entity
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

 private

 def set_entity
  @entity = Business.find params[:id]
 end

 def whitelist
   params.require(:business).permit(:name, :description, :city, :about, :work, :website, :email, :phone)
 end
end
