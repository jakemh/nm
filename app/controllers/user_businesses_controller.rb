class UserBusinessesController < ApplicationController
  def index
    render json: entity.businesses
  end
end
