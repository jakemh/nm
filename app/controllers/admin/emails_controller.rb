class Admin::EmailsController < Admin::AdminController
  protected
    def model_type
      Email
    end
end
