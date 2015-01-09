class Admin::ConnectionsController <  Admin::AdminController
  def index
    @connections = Connection.all.where.not(:type => "Ownership")
  end

  # def show
  # end

  protected
    def model_type
      Connection
    end
end
