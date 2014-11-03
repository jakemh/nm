class SentMessagesController < MessagesController

  def index
    render json: entity.sent_messages
  end

  def show
    render json: entity.sent_messages.find(params[:id].split(","))
  end

end
