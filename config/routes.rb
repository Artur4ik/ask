Rails.application.routes.draw do
  scope "/:locale" do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users do
      get :following, :followed
      resources :questions
    end

    get '/user/feed', to: "users#feed"
    post '/likes', to: 'likes#create'
    resources :relationships, only: [:create, :destroy]
  end
  root 'users#index'
  get '/lang', to: 'application#change_language'
end

Rails.application.routes.default_url_options[:locale] = I18n.locale
