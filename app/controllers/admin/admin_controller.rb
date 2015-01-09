class Admin::AdminController < ApplicationController
  
  layout "admin_index"
  authorize_resource

  attr_accessor :model_name

  def index(options = {})
    #eg Flag -> @flags
    # params[:reverse] = true
    @model = model_type

    if model_type
      models = model_type.all.sort_by{|e| e.send(sort) || ""}
      models.reverse! if reverse
      instance_variable_set("@#{model_type.to_s.downcase.pluralize}", models)
    else 
      raise 'model type is undefined'
    end
  end

  def show 
    redirect_to [:admin, :users]
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
    def models 

    end

    def model_type
      nil
    end

    def model_name
      
      @model_name ||= model_type.to_s.downcase.pluralize
    end

    def sort
      params[:sort] || :id
    end

    def reverse 
      if params[:reverse] && (params[:reverse] == true || params[:reverse] == "true")
        return true
      else return false
      end
    end
end
