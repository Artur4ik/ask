Rails.application.routes.draw do
  scope "/:locale" do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    get '/users/:id', to: 'questions#user'
    get '/', to: 'questions#index'
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"

    resources :questions
  end
  root 'questions#root'
end

Rails.application.routes.default_url_options[:locale] = I18n.locale
