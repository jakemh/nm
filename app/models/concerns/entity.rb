module Directory
  extend ActiveSupport::Concern
  included do
    has_many :flags, :as => :flaggable
  end

end
