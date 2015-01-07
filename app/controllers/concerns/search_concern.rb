module SearchConcern
  extend ActiveSupport::Concern

  included do
  
  end

  def search_for(entity, query)
    entity.search(
             query,  
              fields: 
                search_fields
              )
  end

  def search_for_multiple(entities, query)
    entities[0].search(
    query,  
    fields: 
      search_fields, 
    index_name: entities.map{|e| e.searchkick_index.name})
    .map{|e| e}
      # .map {|e| {
      #   "name" => e.name,
      #   "url" => view_context.url_for(e)}
      # }
  end

  def formatted_search_results(entity, query)
    search_for(entity, query).map{|e| e}
  end

  def search_fields
    [
      {name: :word_start},
      {item: :word_start},
      {url: :word_start},
      {first_name: :word_start},
      {last_name: :word_start},
      {description: :word_start},
      {website: :word_start},
      {zip: :word_start},
      {industry: :word_start},
      {business_type: :word_start}
    ]
  end

end