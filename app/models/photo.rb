class Photo < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>',
      cover: '735x200>'
    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.default
    
  end

end
