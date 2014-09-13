class Ownership < Connection
  # belongs_to :user
  # belongs_to :business
  belongs_to :connect_to, :class_name => "Business"

end
