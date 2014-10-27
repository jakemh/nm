class Me::ReceivedMessagesController < ApplicationController
  def index
    @entity = if params[:entity_type] == "User"
      current_user
    elsif params[:entity_type] == "Business"
      current_user.businesses.find(params[:business_id])
    end
    @received_messages = if params[:id]
      current_user.received_messages.find(params[:id].split(","))
    else current_user.received_messages
    end
    render json: @received_messages

  end

  def show
    @entity = if params[:entity_type] == "User"
      current_user
    elsif params[:entity_type] == "Business"
      current_user.businesses.find(params[:business_id])
    end
    @received_messages = if params[:id]
      current_user.received_messages.find(params[:id].split(","))
    else current_user.received_messages
    end
    render json: @received_messages
  end

  private
  def whitelist
    params.require(:message).permit(:content, :parent_id, :type)
  end
end
