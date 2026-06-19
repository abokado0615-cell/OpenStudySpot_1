# app/controllers/user_registrations_controller.rb
class UserRegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end