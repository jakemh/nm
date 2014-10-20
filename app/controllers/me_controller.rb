class MeController < ApplicationController
  before_filter :authenticate_user!
  include SearchConcern
  def autocomplete
    render json: search_for_multiple([Business, User], params[:q]).to_json
  end

  # layout 'layouts/profile'
end
