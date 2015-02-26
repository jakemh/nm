class AffiliationsController < ApplicationController
  def create
    a = entity.affiliations.build whitelist
    if a.save
      render json: a
    else
      render json: a.errors.to_json
    end
  end

  def show
    render json: parse_show_array(Affiliation).sort_by{|p| p.id}

  end

  def destroy
    aff = Affiliation.find params[:id]
    if aff.destroy
      render json: aff
    else
      render json: aff.errors.to_json
    end
  end

  protected
  def whitelist
    params.require(:affiliation).permit(:branch_id)
  end

end
