module Entity
  extend ActiveSupport::Concern
  included do
    has_many :flags, :as => :flaggable
    has_many :photos, :as => :imageable, :dependent => :destroy
  end

end
