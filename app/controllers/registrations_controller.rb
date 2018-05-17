class RegistrationsController < Devise::RegistrationsController
  protected

  def token
  end

  def after_sign_up_path_for(resource)
    redirect_to token_path # Or :prefix_to_your_route
  end
end
