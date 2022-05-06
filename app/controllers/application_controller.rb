class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    if params[:locale].nil?
      @ip_info = Geocoder.search(request.remote_ip).first
      case @ip_info.country
      when "RU"
        I18n.locale = :ru
      when "BY"
        I18n.locale = :ru
      else
        I18n.locale = :en
      end
      flash[:primary] = "#{t('application.language_notice')}: #{@ip_info.data["ip"]}, #{@ip_info.data['city']}, #{@ip_info.data['country']}"
    else
      I18n.locale = params[:locale]
    end

  end

  def change_language

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
