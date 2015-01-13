class AffiliationsController < ApplicationController
  def create
    a = entity.affiliations.build whitelist
    if a.save
      render json: a
    else 
      render json: a.errors.to_json
    end
  end

  def destroy
  end

  protected
  def whitelist
    params.require(:affiliation).permit(:branch_id)
  end
end
