class BusinessConnection < Connection
  belongs_to :connect_to, :class_name => "Business"
end
