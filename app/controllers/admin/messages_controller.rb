class Admin::MessagesController < Admin::AdminController
  def index
    @messages = Message.all
  end

  def show
  end
end
