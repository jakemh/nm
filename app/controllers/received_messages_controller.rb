class ReceivedMessagesController < MessagesController

  def index
    # byebug
    render json: entity.received_messages.from_entity(@from_entity)
  end

  def show
    render json: entity.received_messages.find(params[:id].split(","))
  end

end
