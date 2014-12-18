class Admin::MessagesController < Admin::AdminController
  def index
    @messages = Message.all
  end

  def show
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
        flash[:notice] = "Message was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        redirect_to_back
    end
  end
end
