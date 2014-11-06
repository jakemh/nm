class MessageResponsesController < MessagesController
  def index
    message_id = params[:sent_message_id] || params[:received_message_id]
    render json: Message.find(message_id).responses
  end

  def show
  end

  def create
    m = entity.send_message_to([to_entity], post)
    if m.save
      # redirect_to [:me, :messages]
      render json: m
    end
  end
end
