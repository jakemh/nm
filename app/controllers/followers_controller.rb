class FollowersController < ApplicationController

  def index
    @followers = entity.inverse_connections
    render json: @followers, each_serializer: FollowerSerializer
  end
 
 def create
   @connection = entity.connections.build(whitelist)
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

 private
 def whitelist
   params.permit(:connect_to_id, :type)
 end
end
