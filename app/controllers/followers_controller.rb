class FollowersController < ApplicationController

  def index
    @followers = entity.inverse_connections
    render json: @followers, each_serializer: FollowerSerializer
  end
 
  def create
    type = Connection.connection_type(entity.class.name, whitelist[:type])
    
   @connection = entity.connections.build({
      :connect_to_id => whitelist[:connect_to_id],
      :type => type})
    if @connection.save
      flash[:notice] = "Added #{params[:type]}"
      # redirect_to_back root_url
      render json: @connection
    else
      flash[:error] = "Unable to add #{params[:type]}."
      # redirect_to_back
      render json: @connection

    end


  end

  def show
    @followers = parse_show_array(Connection)
    
    render json: @followers, each_serializer: FollowerSerializer
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


 private
 def whitelist
   params.require(:follower).permit(:connect_to_id, :type)
 end
end
