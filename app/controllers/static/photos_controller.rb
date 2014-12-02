class Static::PhotosController < PhotosController
 def create

   @entity = set_entity
   @photo = build_photo(@entity)
   
   if @photo.save
    
     respond_to do |format|
       format.js 
     end   
   else
   end
 end
end
