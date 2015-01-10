class Admin::ConnectionsController <  Admin::AdminController
  def index
    super("type != 'Ownership'")
  end

  # def show
  # end

  protected
    def model_type
      Connection
    end
end
