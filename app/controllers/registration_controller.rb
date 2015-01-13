class RegistrationController < Devise::RegistrationsController
  before_filter :authenticate_user!
  
  layout 'signup_bar'

  
  before_filter :configure_permitted_parameters, if: :devise_controller?

   protected
   
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << 
      [
      :first_name, 
      :last_name, 
      :zip, 
      :is_veteran, 
      :profile_photo_id, 
      affiliations_attributes: [:branch_id]
      ]
   end

   def after_sign_up_path_for(resource)
    new_me_business_url
   end
end
