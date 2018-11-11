class User::PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    flash[:notice] =
      t('.password_reset_email_sent', email: resource.email)
    respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
  end
end
