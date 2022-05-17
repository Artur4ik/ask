Rails.application.routes.draw do
  scope "/:locale" do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users do
      get :following, :followed
      resources :questions
    end
    resources :relationships, only: [:create, :destroy]
    get '/user/feed', to: "users#feed"
    get '/user/info', to: "users#info"
    get '/home', to: "pages#home"
    get '/about', to: "pages#about"
    post '/likes', to: 'likes#create'
    get '/lang', to: 'pages#language'
  end
  root "pages#home"

end

Rails.application.routes.default_url_options[:locale] = I18n.locale
