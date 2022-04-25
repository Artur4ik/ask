class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    questions_path
  end

  def after_sign_out_path_for(resource)
    questions_path
  end

  def after_sign_up_path_for(resource)
    questions_path
  end

  def after_update_path_for(resource)
    questions_path
  end

end
