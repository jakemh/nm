class UsersController < EntityController
  # layout "external_profile_user" 
  before_filter :authenticate_entity, only: [:new, :create, :edit, :save, :update]
  skip_before_action :authenticate
  include FeedConcern
  include EntityConcern

  def index
    render json: User.includes(:connections).all
    # @distance = params[:distance]
    # @users = User.where("users.id != ?", current_user.id)
    # respond_to do |format|
    #   format.html
    #   format.json {render json: @users}
    # end
  end

  def update
    name = params[:name]

    @entity = update_entity do |hash|
      if !name.blank?
        name_hash = {}
        name_array = name.split("\s")
        name_hash[:first_name] = name_array[0]
        name_hash[:last_name] = name_array[1..-1].join("\s")
      end

      hash = hash.merge(name_hash)


    end
    render json: @entity

    # whitelist.delete_if { |key, value| value.blank? }
    # @entity = entity
    # name = params[:name]
    # name_hash = {}
    # new_skills = params.permit(skills: [:name])["skills"]
    # old_skills = @entity.skills.map{|s| {"name" => s.name} }  
    # deleted_skills = old_skills - new_skills
    # added_skills = new_skills - old_skills
    # deleted_entity_skills = @entity.skills.where(name: deleted_skills.map{ |ds| ds["name"]})

    # if !name.blank?
    #   name_array = name.split("\s")
    #   name_hash[:first_name] = name_array[0]
    #   name_hash[:last_name] = name_array[1..-1].join("\s")
    # end

    # @entity.update_attributes(whitelist.merge(name_hash))
    # @entity.skills.destroy deleted_entity_skills
    # @entity.skills.build added_skills

    # # entity.skills.build(params.permit(skills: [:name]))
    # # @entity.skills.build(skills)

    # @entity.save
    # render json: @entity
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
    params.require(:user).permit(:name, :city, :about, :work, :website, :profile_photo_id)
  end
end
