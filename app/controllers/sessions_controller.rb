
class SessionsController < Devise::SessionsController
  
  
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  layout 'signup_bar'
   protected
   def after_sign_in_path_for(resource)
     me_path #your path
   end
   # def configure_permitted_parameters
   #   devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :zip, :is_veteran]
   # end

   # def after_sign_up_path_for(resource)
   #  new_me_business_url
   
   # end
end
