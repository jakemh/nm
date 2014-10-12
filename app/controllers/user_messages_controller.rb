class UserMessagesController < MessagesController

  def create
    super
    user = User.find(params[:user_id])
     m = @from.send_message_to([user], whitelist)
     if m.save
       redirect_to [:me, :messages]
     end
  end

end
