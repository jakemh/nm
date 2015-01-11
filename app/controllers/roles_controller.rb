class RolesController < ApplicationController

  def create
    a = user.assignments.build :role => Role.add(whitelist[:roleable_type], whitelist[:classification_options])
    a = entity.assignments.build 
  end

  def destroy
  end

  protected
  def whitelist
    params.require(:role).permit(:roleable_type)
  end
end
