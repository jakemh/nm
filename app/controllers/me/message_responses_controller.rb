class Me::MessageResponsesController < MessagesController

  # def show
  #   @entity = if params[:entity_type] == "User"
  #     current_user
  #   elsif params[:entity_type] == "Business"
  #     current_user.businesses.find(params[:business_id])
  #   end
  #   @sent_messages = if params[:id]
  #     current_user.sent_messages.find(params[:id].split(","))
  #   else current_user.sent_messages
  #   end
  #   render json: @sent_messages
  # end

  def show
    @entity = if params[:entity_type] == "User"
      current_user
    elsif params[:entity_type] == "Business"
      MessageResponse.find(params[:business_id])
    end
    @sent_messages = if params[:id]
      MessageResponse.find(params[:id].split(","))
    # else current_user.sent_messages
    end
    render json: @sent_messages

  end

  def create
    # user = User.find(params[:user_id])
     m = from_entity.send_message_to([to_entity], post)
     if m.save
       # redirect_to [:me, :messages]
       render json: m
     end
  end
  
end
