class AssignmentsController < ApplicationController

  def create
    a = entity.assignments.build :role => Role.getRole(whitelist)
    if a.save
      render json: a
    else render json: {:status => false}

    end
  end

  def destroy
  end

  protected
  def whitelist
    params.permit(:roleable_type, :category)
  end
end
