class SentMessagesController < MessagesController

  def index
    # render json: entity.sent_messages.from_entity(@from_entity)
    render json: entity.sent_messages.joins(:message_recipients).where('"message_recipients".?=?', Post.id_sym(@from_entity.class.name), @from_entity.id)

  end

  def show
    render json: entity.sent_messages.find(params[:id].split(","))
  end

end
