class Me::MessagesController < Me::PostsController
  include FeedConcern
  layout "profile"

  def index
    @default_entity = current_user
    @received_messages = build_sorted_posts(@default_entity.received_messages)
    @sent_messages = build_sorted_posts(@default_entity.sent_messages)

    @post = Message.new
    @select = select_array
  end
  private
  def whitelist
    params.require(:message).permit(:content, :parent_id, :type)
  end
 
end
