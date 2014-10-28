class Me::ResponsesController < Me::PostsController
  private
    # def index
    #   render json: Ressp.all.where(type: [nil, ""])

    # end

    def whitelist
      params.require(:response).permit(:content, :parent_id, :type)
    end
end
