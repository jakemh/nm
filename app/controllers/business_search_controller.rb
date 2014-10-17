class BusinessSearchController < ApplicationController
  def index
    search_fields = [
      {name: :text_start},
      {first_name: :text_start},
      {last_name: :text_start},
      {description: :text_start},
      {website: :text_start},
      {zip: :text_start},
      {industry: :text_start},
      {business_type: :text_start}
    ]

    # Business.search_kick.name
    @businesses = Business.search(
          params["q"],  
          fields: 
            search_fields
          )
    render json: @businesses.map{|b| b}
  end
end
