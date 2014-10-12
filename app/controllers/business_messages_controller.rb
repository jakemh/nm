class BusinessMessagesController < MessagesController
  def create
    super
    business = Business.find(params[:business_id])
    m = @from.send_message_to([business], whitelist)
    if m.save
      redirect_to [:me, :messages]
    end
  end
end
