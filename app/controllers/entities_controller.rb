class EntitiesController < ApplicationController
  def index
    if params[:first_letter]
      render json: (User.by_first_letter(params[:first_letter]) + Business.by_first_letter(params[:first_letter])).sort_by{|e| e.name}, each_serializer: EntitySerializer
    else
      render json: User.all + Business.all

    end
  end

  def show
  end
end
