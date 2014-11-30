class ReceivedMessagesController < MessagesController

  def index
    # render json: entity.received_messages.includes(:message_recipients).from_entity(@from_entity), each_serializer: ReceivedMessageSerializer
    @received_messages = 
      if params[:unread]
        current_user.all_unread_messages
      else 
        current_user.all_received_messages(@from_entity)
      end

    render json: @received_messages, each_serializer: ReceivedMessageSerializer
  end

  def show
    render json: entity.received_messages.find(params[:id].split(","))
  end

end
