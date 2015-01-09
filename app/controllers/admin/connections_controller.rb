class Admin::ConnectionsController <  Admin::AdminController
  def index
    super("type != ownership")
  end

  # def show
  # end

  protected
    def model_type
      Connection
    end
end
