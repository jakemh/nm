class Me::MessagesController < Me::PostsController
  include FeedConcern
  layout "profile"

  def index
    @business_entity = current_user.businesses.find(params[:business_id]) if params[:business_id]
    @default_entity = @business_entity || current_user
    @received_messages = build_sorted_posts(@default_entity.received_messages)
    @sent_messages = build_sorted_posts(@default_entity.sent_messages)

    @post = Message.new
    @select = select_array

    respond_to do |format|
      format.html

      #prevent paloma from executing
      format.js { render :file => "me/messages/index.js.erb" }


    end
  end
  private
  def whitelist
    params.require(:message).permit(:content, :parent_id, :type)
  end
 
end
