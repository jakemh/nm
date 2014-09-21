#class LandingController < Devise::RegistrationsController
class LandingController < ApplicationController

  def index
    new
  end

  def temporary

  end
  
  def add_email
    save_params = params.require(:email).permit(:email)
    Email.create(save_params)
  end


  # def create
  #   build_resource(sign_up_params)

  #   resource_saved = resource.save
  #   yield resource if block_given?
  #   if resource_saved
  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_flashing_format?
  #       sign_up(resource_name, resource)
  #       respond_to do |format|
  #         format.js 
  #       end
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #       expire_data_after_sign_in!
  #       respond_to do |format|
  #         format.js 
  #       end
  #     end
  #   else
  #     clean_up_passwords resource
  #     @validatable = devise_mapping.validatable?
  #     if @validatable
  #       @minimum_password_length = resource_class.password_length.min
  #     end
  #     respond_with resource
  #   end
  # end

  def selection

  end

  def after_sign_up_path_for(resource)
     selection_path
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :zip, :is_veteran]
   end


end
