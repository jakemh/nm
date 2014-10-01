class Me::ConnectionsController < MeController
  layout "profile"

  def index
    @user = current_user
    @followers = @user.inverse_connections.map{|f| [f.entity_type.find_by_id(f.connect_to_id), f]}.compact
    @following = @user.following.map{|f| [f.entity_type.find_by_id(f.connect_to_id), f]}.compact
    # @business_connections = @user.business_connections 
  end

  
  def create
    @connection = current_user.connections.build(whitelist)
     if @connection.save
       flash[:notice] = "Added #{params[:type]}"
       redirect_to_back root_url
     else
       flash[:error] = "Unable to add #{params[:type]}."
       redirect_to_back
     end
  end

  def destroy
    @connection = current_user.connections.find(params[:id])
     if @connection.destroy
       flash[:notice] = "Removed #{params[:type]}."
       redirect_to_back
    else
       flash[:error] = "Unable to add #{params[:type]}."
       redirect_to_back
     end
  end

  def update
  end

  def show
  end

  protected
    def whitelist
      params.permit(:connect_to_id, :type)
    end
end
