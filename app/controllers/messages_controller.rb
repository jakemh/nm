class MessagesController < ApplicationController
  before_filter :set_from_entity, :set_to_entity

  def index
  end

  def show
  end

  def new
  end

  def create

    # from_type = type_array[0]
    # from_id = type_array[1]
    # @from = from_type.constantize.find(from_id)
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
  
  def edit
  end

  def update
  end

  def destroy
  end

   private
    def set_from_entity
      _from_entity = whitelist[:from_type].constantize.find(whitelist[:from_id])
      if [current_user].append(current_user.businesses).include? _from_entity
        @from_entity = _from_entity
      else raise 'SUSPICIOUS FROM ENTITY!'
      end
    end

    def set_to_entity
      _to_entity = whitelist[:to_type].constantize.find(whitelist[:to_id])
      #currently we allow any user to sent PMs to any user
      @to_entity = _to_entity
    end


    def from_entity
      @from_entity
    end

    def to_entity
      @to_entity
    end

    def post
      {content: whitelist[:content]}
    end

    def message_type
      # :user_message if params.has_key? :user_message
      # :business_message if params.has_key? :business_message
      :user_message
    end

    def whitelist
      p "TYPE: ", message_type
      params.require(message_type).permit(
        :content, 
        :subject, 
        :from_id, 
        :from_type,
        :to_id,
        :to_type
        )
    end

    # def type_array
    #   JSON.parse(params.permit(:type_array)[:type_array])
    # end

end
