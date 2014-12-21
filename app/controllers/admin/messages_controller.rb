class Admin::MessagesController < Admin::AdminController

  protected
    def model_type
      Message
    end
end
