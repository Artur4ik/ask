Rails.application.routes.draw do
  scope "/:locale" do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    get '/users/:id', to: 'questions#user'

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"

    resources :questions
  end
  root 'questions#index'
  get '/lang', to: 'application#change_language'
end

Rails.application.routes.default_url_options[:locale] = I18n.locale
