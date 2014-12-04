class UserBusinessesController < ApplicationController
  def index
    render json: entity.businesses, each_serializer: BusinessSerializer
  end
end
