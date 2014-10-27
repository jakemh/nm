class Me::MessagesController < Me::PostsController
  include FeedConcern
  # include ActionController::Live
  # Mime::Type.register "text/event-stream", :stream

  layout "profile"

  def send_data
    response.headers['Content-Type'] = 'text/event-stream'
       sse = SSE.new(response.stream, retry: 1000, event: "event-name")
       # 10.times do 

       sse.write({ name: 'John'}, id: 10, event: "other-event", retry: 1000)
      # end
     ensure
       sse.close


  end

  def index

    # response.headers['Content-Type'] = 'text/event-stream'
    # begin
    #   sse = SSE.new(response.stream, retry: 300, event: "event-name")
    #   # loop do
    #   sse.write({ name: Time.now})
    #     # response.stream.write "data: #{generate_new_values}\n\n" # Add 2 line breaks to delimitate events
    #     # sleep 5.second
    #   # end
    # rescue IOError # Raised when browser interrupts the connection
    # ensure
    #   sse.close
    #   # response.stream.close # Prevents stream from being open forever
    # end

    
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
    
    respond_to do |format|      
      format.html
      format.json {render json: @sent_messages}
    end

    # @received_messages = build_sorted_posts(@default_entity.received_messages)
    # @sent_messages = build_sorted_posts(@default_entity.sent_messages)
    # current_user.message_recipients.mark_as_read! :all, :for => current_user
    # @business_entity = current_user.businesses.find(params[:business_id]) if params[:business_id]
    # @default_entity = @business_entity || current_user
    # @received_messages = build_sorted_posts(@default_entity.received_messages)
    # @sent_messages = build_sorted_posts(@default_entity.sent_messages)

    # @post = Message.new
    # @select = select_array

    # respond_to do |format|
    #   format.html

    #   #prevent paloma from executing
    #   format.js
    #   # format.js { render :file => "me/messages/index.js.erb" }


    # end
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

  private
  def whitelist
    params.require(:message).permit(:content, :parent_id, :type)
  end
 
end
