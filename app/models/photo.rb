class Photo < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h  
  belongs_to :imageable, :polymorphic => true
  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '165x165#',
      medium: '300x300>',
      cover: '735x200>'
    }, :processors => [:cropper] 

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # after_update :reprocess_image, :if => :cropping?  
  
  def cropping?  
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?  
  end  
  
    

  def crop_image
    if self.cropping?
      self.reprocess_image
    end
  end

  def reprocess_image  
    image.reprocess!  
  end 
  def self.default
    
  end

end
