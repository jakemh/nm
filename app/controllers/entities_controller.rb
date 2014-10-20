class EntitiesController < ApplicationController
  def index
    render json: (User.by_first_letter(params[:first_letter]) + Business.by_first_letter(params[:first_letter])).sort_by{|e| e.name}, each_serializer: EntitySerializer
  end

  def show
  end
end
