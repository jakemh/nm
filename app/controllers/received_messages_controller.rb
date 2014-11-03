class ReceivedMessagesController < MessagesController

  def index
    render json: entity.received_messages
  end

  def show
    render json: entity.received_messages.find(params[:id].split(","))
  end

end
