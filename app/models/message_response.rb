class MessageResponse < Message

  # def show

    # @sent_messages = if params[:id]
    #   MessageResponse.find(params[:id].split(","))
    # # else current_user.sent_messages
    # end
    # render json: @sent_messages

  # end

  def create
    # user = User.find(params[:user_id])

     # m = from_entity.send_message_to([to_entity], post)
     m = entity.send_message_to([to_entity], post)
     if m.save
       # redirect_to [:me, :messages]
       render json: m
     end
  end
end
