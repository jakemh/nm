module Search
  extend ActiveSupport::Concern

  included do
    has_many :locations, :as => :locatable, :dependent => :destroy
    after_save :add_location, :if => :zip_changed?
  end

  def add_location
    self.locations.create
  end

  def location
    self.locations.last
  end

end
