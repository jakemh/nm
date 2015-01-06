class InteractionsController < ApplicationController
  INTERACTIONS = 10
  def index
    require 'ostruct'

    @entity = entity
    i = InteractionAll.new(@entity)
    l = i.total_count_list(INTERACTIONS)

    obj = OpenStruct.new
    obj.interactions = l.map{|e| e.keys.first}
    obj.dates = l.map{|k| k.values.first.first }.flatten
    render json: obj.to_json
  end

end
