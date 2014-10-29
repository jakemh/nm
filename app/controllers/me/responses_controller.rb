class Me::ResponsesController < Me::PostsController

  def index
    render json: Post.where(:type => "Response")
  end

	def show
	  render json: Post.where(:id => params[:id].split(","), :type => "Response")
	end

  private
    # def index
    #   render json: Ressp.all.where(type: [nil, ""])

    # end
   
    def whitelist
      params.require(:response).permit(:content, :parent_id, :type)
    end
end
