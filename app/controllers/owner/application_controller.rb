class Owner::ApplicationController < ActionController::Base
  layout 'customer'
  before_action :authorize_owner!

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    root_path
  end


  def authorize_owner!
    authenticate_user!

    render 'errors/not_found' unless current_user.owner?
  end
end
