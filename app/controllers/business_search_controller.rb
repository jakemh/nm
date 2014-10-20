class BusinessSearchController < SearchController
  

  def index
    
    # Business.search_kick.name
    render json: formatted_search_results(Business, params["q"])
  end
end
