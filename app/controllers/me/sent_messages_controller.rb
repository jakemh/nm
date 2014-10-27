class Me::SentMessagesController < ApplicationController
  def index
    @post = Message.new
    @default_entity = nil
    if params[:user_id]
      if params[:user_id].to_i == current_user.id
        @default_entity = current_user
      else 
        raise 'wrong user id supplied'
      end

    else @default_entity = current_user
    end
    @sent_messages = if params[:ids]
      @default_entity.sent_messages.find(params[:ids])
    else 
      @default_entity.sent_messages
    end
    
    render json: @sent_messages
  end

  def show
    @entity = if params[:entity_type] == "User"
      current_user
    elsif params[:entity_type] == "Business"
      current_user.businesses.find(params[:business_id])
    end
    @sent_messages = if params[:id]
      current_user.sent_messages.find(params[:id].split(","))
    else current_user.sent_messages
    end
    render json: @sent_messages
  end

end
