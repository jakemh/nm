module RegistrationHelper
  def veteran_error_helper(resource)
    "error-border" if !resource.is_veteran_accepted?
  end
end
