class SentMessagesController < MessagesController

  def index
    # render json: entity.sent_messages.from_entity(@from_entity)
    where_clause = 
      if @from_entity.class.name == "User"
        '"message_recipients"."user_id"'
      elsif @from_entity.class.name == "Business"
        '"message_recipients"."business_id"'
      end
    render json: entity.sent_messages.joins(:message_recipients).where("#{where_clause}=?", @from_entity.id)

  end

  def show
    # @sent_messages = parse_show_array(Message)
    @sent_messages = entity.messages.find(parse_ids(params[:id]))
    render json: @sent_messages, each_serializer: SentMessagesSerializer
    # render json: entity.sent_messages.find(params[:id].split(","))
  end

end
