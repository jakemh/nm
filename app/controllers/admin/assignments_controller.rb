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
    # user = User.find(params[:user_id])
    # role = params[:classification].constantize.new
    assignments = Assignment.where(id: params[:id]) if params[:id]
    user = assignments.count > 0 ? assignments.first.user : User.find(params[:user_id])
    assignments = assignments || user.assignments.where(role: Role.add(classification.constantize, classification_options))
    classification = assignments.first.role ? assignments.first.role.roleable_type : "Missing Role"

    if assignments.count > 0
      
      if (user.id == 1 || user == User.first) && classification == "AdminRole"
        flash[:notice] = ">:("
        redirect_to_back
      else
        assignments.destroy_all
        flash[:notice] = "Removed #{classification}"
        redirect_to_back
      end
    else
      flash[:error] = "Did not have #{classification}"
      redirect_to_back
    end
  end

  protected
    def model_type
      Assignment
    end

    def whitelist
      params.permit(:classification, :classification_options)
    end
end
