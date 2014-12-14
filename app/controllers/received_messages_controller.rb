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
    @received_messages = parse_show_array(Message)
    # @received_message = entity.received_messages.find(params[:id])

    # if params[:read]
    #   @received_message.mark_as_read! :for => current_user
    # end
    render json: @received_messages, each_serializer: ReceivedMessageSerializer
    # render json: entity.received_messages.find(params[:id].split(","))
  end

  def update
    @received_message = Message.find(params[:id])
    # @received_message = entity.received_messages.find(params[:id])
    if whitelist[:unread] == false
      @received_message.mark_as_read! :for => current_user
    end

    if @received_message.save
      render json: @received_message
    end
  end
  

  def whitelist
    params.require(:received_message).permit(
     :unread
     )
 end


end
