class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "customer"
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
