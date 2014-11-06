class UsersController < ApplicationController
  layout "external_profile_user" 
  before_filter :authenticate_entity, only: [:new, :create, :edit, :save, :update]
  include FeedConcern

  def index
    @distance = params[:distance]
    @users = User.where("users.id != ?", current_user.id)
    respond_to do |format|
      format.html
      format.json {render json: @users}
    end
  end

  def update
    whitelist.delete_if { |key, value| value.blank? }
    name = params[:name]
    name_hash = {}
    skills = params.permit(skills: [:name])["skills"]
  
    if !name.blank?
      name_array = name.split("\s")
      name_hash[:first_name] = name_array[0]
      name_hash[:last_name] = name_array[1..-1].join("\s")
    end
    entity.update_attributes(whitelist.merge(name_hash))
    entity.skills.destroy_all
    # entity.skills.build(params.permit(skills: [:name]))
    entity.skills.build(skills)
    entity.save
    render json: entity
  end

  def show
    # @distance = params["distance"]
    respond_to do |format|
      format.html do 
        # @message = Message.new
        # @post = Post.new
        #refactor this name
        # @select = select_array
        # user = User.find(params[:id])
        # @entity = user
        # @default_entity = user
        # @posts = build_sorted_posts(user.posts.where(type: [nil, ""]))
      end
        format.json do 
          @users = 
          if params[:id] == "current"
            current_user
          else 
            ids = params[:id].split(",")
            @users = 
              if ids.length == 1
              # current_user.businesses.find(params[:id].split(","))
                User.find(ids[0])
              elsif ids.length > 1
                User.find(ids)
            # else current_user.users
              end
            end
          render json: @users
        end
      # format.json  do 
      #   @user = params[:id] == "current" ? current_user : User.find(params[:id])
      #   render json: @user
      # end
    end
  end

  private

  # def skills
  #   params.permit(skills: [:name])
  # end

  def set_entity
   @entity = User.find params[:id]
  end

  def whitelist
    params.require(:user).permit(:name, :city, :about, :work, :website)
  end
end
