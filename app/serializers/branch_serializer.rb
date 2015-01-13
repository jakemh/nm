class BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_src


  def image_src
    scope.image_url("military_icons/#{object.name.parameterize.underscore.intern}.png")
  end
end
