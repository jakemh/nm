class Admin::AssignmentsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    ass = nil
    if user.role?(whitelist[:classification]) || user.role?(whitelist[:classification].titleize)
      flash[:error] = "Already is #{whitelist[:classification]}"
      redirect_to_back root_url
    else 
      ass = user.assignments.build :role_id => Role.enum(whitelist[:classification])
      if ass.save
        flash[:notice] = "Made #{whitelist[:classification]}"
        redirect_to_back root_url
      else
        flash[:error] = "Unable to make #{whitelist[:classification]}"
        redirect_to_back
      end
    end

   
  end

  def destroy
    user = User.find(params[:user_id])
    if user.role?(params[:id]) ||  user.role?(params[:id].titleize)
      role_id = Role.enum(params[:id])

      if (user.id == 1 || user == User.first) && role_id == 1
        flash[:notice] = "Hey!! >:("
        redirect_to_back
      else
        user.assignments.where(:role_id => Role.enum(params[:id])).destroy_all
        flash[:notice] = "Removed #{params[:id]}"
        redirect_to_back
      end
    else
      flash[:error] = "Was not #{params[:id]}"
      redirect_to_back
    end
  end

  protected
    def whitelist
      params.permit(:classification)
    end
end
