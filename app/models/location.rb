class Location < ActiveRecord::Base
  belongs_to :locatable, :polymorphic => true
  geocoded_by :get_address_from_parent
  after_validation :geocode


  def get_address_from_parent
    locatable.zip
  end
end
