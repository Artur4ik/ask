module ApplicationHelper
  def locale_to_string(locale)
    return t('application.root_en') if (locale == :en)
    return t('application.root_ru') if (locale == :ru)
    return nil
  end

  def locale_for_emoji(locale)
    return "us" if (locale == :en)
    return locale.to_s
  end
end
