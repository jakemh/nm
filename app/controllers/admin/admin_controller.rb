class Admin::AdminController < ApplicationController
  load_and_authorize_resource

  layout "admin_profile"
  def index
    #eg Flag -> @flags
    if model_type
      models = model_type.all
      instance_variable_set("@#{model_type.to_s.downcase.pluralize}", models)
    else 
      raise 'model type is undefined'
    end
  end

  def show 
    redirect_to [:admin, :emails]
  end

  def destroy
    @model = model_type.find(params[:id])
    if @model.destroy
        flash[:notice] = "#{@model.class.to_s} was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Sorry!"
        redirect_to_back
    end
  end

  protected
    def model_type
      nil
    end
end
