class PointsController < ApplicationController

  def create

  end

  protected
    def whitelist
      params.permit(:score, :user_id, :business_id)
    end
end
