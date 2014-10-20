module Search
  extend ActiveSupport::Concern

  included do
    has_many :locations, :as => :locatable, :dependent => :destroy
    after_save :add_location
  end

  def add_location
    self.locations.create
  end
end
