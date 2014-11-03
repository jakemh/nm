class MessageResponsesController < MessagesController
  def index
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
