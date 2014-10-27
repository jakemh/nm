class MessagesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    from_type = type_array[0]
    from_id = type_array[1]
    @from = from_type.constantize.find(from_id)
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
    def whitelist
      params.require(:message).permit(:content, :subject)
    end

    def type_array
      JSON.parse(params.permit(:type_array)[:type_array])
    end

end
