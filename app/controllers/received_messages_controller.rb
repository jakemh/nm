class ReceivedMessagesController < MessagesController

  def index
    # @received_messages = 
    #   if params[:unread]
    #     current_user.all_unread_messages
    #   else 
    #     current_user.all_received_messages(@from_entity)
    #   end

    # render json: @received_messages, each_serializer: ReceivedMessageSerializer
  end

  def show
    # @received_messages = parse_show_array(Message)
    @received_messages = entity.received_messages.find(parse_ids(params[:id]))
    render json: @received_messages, each_serializer: ReceivedMessageSerializer
  end

  def update
    @received_message = Message.find(params[:id])
    if whitelist[:unread] == false
      @received_message.mark_as_read! :for => current_user
    end

    if @received_message.save
      render json: @received_message
    end
  end
  
  protected

  protected

  def authentiate_message_access
    return true if @entity == current_user 
    return true if current_user.businesses.include? @entity
    return false
  end

  def whitelist
    params.require(:received_message).permit(
     :unread
     )
 end


end
