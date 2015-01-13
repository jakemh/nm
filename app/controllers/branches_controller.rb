class BranchesController < ApplicationController
  def index
    render json: Branch.all
  end

  def show
    render json: parse_show_array(Branch).sort_by{|p| p.id}
  end
end
