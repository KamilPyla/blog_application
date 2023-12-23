Rails.application.routes.draw do
  resources :events
  resources :posts
  resources :product_sub_categories
  resources :product_categories
  resources :post_categories

  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'pages#home'
  get 'pages/users'
  get 'pages/admin'

  get 'activity_logs', to: 'activity_logs#index'
  get 'activity_logs/:action_subject', to: 'activity_logs#action_subject', as: 'activity_logs_source'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :users do
    get '/:uuid', to: 'profiles#show', as: 'profile'
    get '/name/:login', to: 'profiles#show', as: 'profile_by_login'

    get '/edit/:uuid', to: 'profiles#edit', as: 'edit_profile'
    get '/followers/:uuid', to: 'profiles#show_followers', as: :show_followers
    get '/following/:uuid', to: 'profiles#show_following', as: :show_following
    get '/blocked/:uuid', to: 'profiles#show_blocked', as: :show_blocked

    post '/edit/:uuid', to: 'profiles#update', as: 'update_profile'
    post '/block/:uuid', to: 'profiles#block', as: 'profile_block'
    post '/unblock/:uuid', to: 'profiles#unblock', as: 'profile_unblock'
    post '/follow/:uuid', to: 'profiles#follow', as: 'profile_follow'
    post '/unfollow/:uuid', to: 'profiles#unfollow', as: 'profile_unfollow'

  end

  # post 'like/:kind/:id', to: 'reactions#like', as: 'like_activity'
  # post 'dislike/:kind/:id', to: 'reactions#dislike', as: 'dislike_activity'

  get 'comment/:kind/:id', to: 'comments#new', as: 'new_comment'
  post 'comment/:kind/:id', to: 'comments#create', as: 'create_comment'
  delete 'comment/:id', to: 'comments#destroy', as: 'destroy_comment'

  get '/posts/user/:uuid', to: 'posts#users_posts', as: :users_posts
  get '/events/user/:uuid', to: 'events#users_events', as: :users_events


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
