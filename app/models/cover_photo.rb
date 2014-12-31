class CoverPhoto < Photo
  has_attached_file :image, styles: {
      thumb: '100x100>',
      medium: '300x300>',
      cover: '735x250>'
    },
     :processors => [:cropper] 
end
