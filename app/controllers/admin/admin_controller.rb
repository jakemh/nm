class Admin::AdminController < ApplicationController
  load_and_authorize_resource

  layout "admin_profile"
  def index

  end

  def show 
    redirect_to [:admin, :emails]
  end
end
