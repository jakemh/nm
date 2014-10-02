class Me::ResponsesController < Me::PostsController
  private
  def whitelist
    params.require(:response).permit(:content, :parent_id, :type)
  end
end
