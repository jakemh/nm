class SkillsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.skills
  end
end
