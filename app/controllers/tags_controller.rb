class TagsController < ApplicationController
  def index
    business = Business.find(params[:business_id])
    render json: business.tags
  end
end
