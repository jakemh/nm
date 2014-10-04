class SameToSame < Connection

 has_many :friendships, foreign_key: :connect_to_id
end