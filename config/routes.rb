Rails.application.routes.draw do
  scope "/:locale" do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    get '/users/:id', to: 'questions#user'

    resources :questions
  end
  resources :likes
  root 'questions#index'
  get '/lang', to: 'application#change_language'
end

Rails.application.routes.default_url_options[:locale] = I18n.locale
