class UserMessagesController < MessagesController

  def create
    super
    puts "TEST**:", @to
    user = User.find(params[:user_id])
  
    # user.send_message_to([@to], )
  end

end
