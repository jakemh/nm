class Admin::AssignmentsController < Admin::AdminController

  def create
    user = User.find(params[:user_id])
    ass = nil
    role = whitelist[:classification].constantize
    if user.role?(whitelist[:classification]) || user.role?(whitelist[:classification].titleize)
      flash[:error] = "Already is #{whitelist[:classification]}"
      redirect_to_back root_url
    else 
      # ass = user.roles.create :roleable => role.new
      ass = user.assignments.create :role => Role.add(whitelist[:classification], whitelist[:classification_options])
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
    role = params[:id].constantize.new
    if user.role?(params[:id]) ||  user.role?(params[:id].titleize)
      # role_id = Role.enum(params[:id])
      
      if (user.id == 1 || user == User.first) && params[:id] == "AdminRole"
        flash[:notice] = "Hey!! >:("
        redirect_to_back
      else
        # user.assignments.where(:role_id => Role.enum(params[:id])).destroy_all
        user.assignments.joins(:role).where("roles.roleable_type = '#{params[:id]}'").destroy_all
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
      params.permit(:classification, :classification_options)
    end
end
