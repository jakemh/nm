class MeController < ApplicationController
  before_filter :authenticate_user!

  def autocomplete
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
    render json: Business.search(
      params["q"],  
      fields: 
        search_fields, 
      index_name: 
        [Business.searchkick_index.name, User.searchkick_index.name])
        .map {|e| {
          "name" => e.name,
          "url" => view_context.url_for(e)}
        }.to_json
  end

  # layout 'layouts/profile'
end
