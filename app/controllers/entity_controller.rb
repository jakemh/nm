class EntityController < ApplicationController

  def update

  end

  protected
    def update_entity
      whitelist.delete_if { |key, value| value.blank? }
      @entity = entity
      new_skills = params.permit(items: [:name])["items"] || []
      old_skills = @entity.items.map{|s| {"name" => s.name} }  
      deleted_skills = old_skills - new_skills
      added_skills = new_skills - old_skills
      deleted_entity_skills = @entity.items.where(name: deleted_skills.map{ |ds| ds["name"]})
      update_hash = whitelist
      update_hash = yield update_hash if block_given?
      # byebug
      @entity.update_attributes(update_hash)
      @entity.items.destroy deleted_entity_skills
      @entity.items.build added_skills

      # entity.skills.build(params.permit(skills: [:name]))
      # @entity.skills.build(skills)

      @entity.save
      return @entity
    end
end
