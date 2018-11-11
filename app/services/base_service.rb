class BaseService
  attr_reader :current_user, :locale

  def initialize(current_user, locale)
    @current_user = current_user
    @locale = locale.to_s
  end
end
