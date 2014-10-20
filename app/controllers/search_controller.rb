class SearchController < ApplicationController
  include SearchConcern

  def index
    render json: search_for_multiple([Business, User], params[:q]), each_serializer: EntitySerializer
  end
end
