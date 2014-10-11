class BusinessMessagesController < MessagesController
  def create
    super
    business = Business.find(params[:business_id])
    @from.send_message_to([business], whitelist)
  end
end
