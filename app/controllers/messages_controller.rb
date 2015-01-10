class MessagesController < ApplicationController
  before_filter :set_to_entity, only: [:new, :create, :edit, :save]
  before_filter :set_from_entity, only: [:index]
  before_action :authenticate_entity # all actions

  # before_action :authentiate_message_access, only: [:index, :show]
  # before_filter :authenticate_entity, only: [:index, :show]

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

  # def show
  #   @entity = if params[:entity_type] == "User"
  #     current_user
  #   elsif params[:entity_type] == "Business"
  #     current_user.businesses.find(params[:business_id])
  #   end
  #   @sent_messages = if params[:id]
  #     # current_user.sent_messages.find(params[:id].split(","))
  #     MessageResponse.find(params[:id].split(","))
  #   # else current_user.sent_messages
  #   end
  #   render json: @sent_messages

  # end
  def create
    # user = User.find(params[:user_id])
    
     m = entity.send_message_to([to_entity], post)
     if m.save!
       # redirect_to [:me, :messages]
       render json: m, serializer: SentMessagesSerializer
     end
  end

  
  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def authentiate_message_access

  end

   def authenticate_entity
     return true if entity == current_user 
     return true if current_user.businesses.include? entity
     raise CanCan::AccessDenied
   end

    # def set_from_entity
    #   _from_entity = whitelist[:from_type].constantize.find(whitelist[:from_id])
    #   if [current_user].append(current_user.businesses).include? _from_entity
    #     @from_entity = _from_entity
    #   else raise 'SUSPICIOUS FROM ENTITY!'
    #   end
    # end

    def set_to_entity
      _to_entity = to_type.constantize.find(to_id)
      #currently we allow any user to sent PMs to any user
      @to_entity = _to_entity
    end

    def set_from_entity
      if from_type
        _from_entity = from_type.constantize.find(from_id)
        #currently we allow any user to sent PMs to any user
        @from_entity = _from_entity
      else @from_entity = nil
      end
    end


    def from_entity
      @from_entity
    end

    def to_entity
      @to_entity
    end

    def post
      {content: whitelist[:content], :parent_id => whitelist[:parent_id], :type => whitelist[:type]}
    end

    def message_type
      return :user_message if params.has_key? :user_message.to_s
      return :business_message if params.has_key? :business_message.to_s
      
    end

    def to_type
      params[:to_type]
    end


    def to_id
      params[:to_id]
    end

    def from_type
      params[:from_type]
    end

    
    def from_id
      params[:from_id]
    end

    def whitelist
      params.require(:message).permit(
        :content, 
        :subject, 
        :from_id, 
        :from_type,
        :parent_id,
        :to_id,
        :unread,
        :type,
        :to_type
        )
    end

    # def type_array
    #   JSON.parse(params.permit(:type_array)[:type_array])
    # end

end
