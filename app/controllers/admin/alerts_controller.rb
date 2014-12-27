class Admin::AlertsController < Admin::AdminController
  skip_load_and_authorize_resource
  layout "admin_alerts"


  def show
    redirect_to [:admin, :alerts, :points, :posts]
  end


end
