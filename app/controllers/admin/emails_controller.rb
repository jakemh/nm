class Admin::EmailsController < Admin::AdminController
  def index
    @emails = Email.all
  end

  def show
  end
end
