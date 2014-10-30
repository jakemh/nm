class UserMessagesController < MessagesController

  def create
    # user = User.find(params[:user_id])
     m = from_entity.send_message_to([to_entity], post)
     if m.save
       # redirect_to [:me, :messages]
       render json: m
     end
  end

end
