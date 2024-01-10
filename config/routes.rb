Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :events
  resources :posts
  resources :post_categories

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'pages#home'

  get 'activity_logs', to: 'activity_logs#index'
  get 'activity_logs/:action_subject', to: 'activity_logs#action_subject', as: 'activity_logs_source'

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

  get '/messages/:user_uuid', to: 'messages#index', as: :users_conversations
  get '/messages/:sender_uuid/:adressee_id', to: 'messages#new', as: :messages_new
  get '/conversation/:thread_uuid', to: 'messages#show', as: :conversation_show
  post '/conversation/:thread_uuid', to: 'messages#create', as: :messages_create
  delete '/messages/:message_id', to: 'messages#destroy', as: :destroy_message

  post 'like/:kind/:id', to: 'reactions#like', as: 'like_activity'
  delete 'dislike/:kind/:id', to: 'reactions#dislike', as: 'dislike_activity'

  get 'comment/:kind/:id', to: 'comments#new', as: 'new_comment'
  post 'comment/:kind/:id', to: 'comments#create', as: 'create_comment'
  delete 'comment/:id', to: 'comments#destroy', as: 'destroy_comment'

  get '/posts/user/:uuid', to: 'posts#users_posts', as: :users_posts
  get '/posts/for_you/:uuid', to: 'posts#for_you', as: :posts_for_you
  get '/posts/popular/top', to: 'posts#popular', as: :posts_popular

  get '/events/user/:uuid', to: 'events#users_events', as: :users_events
  post 'events/:id/buy_ticket', to: 'events#buy_ticket', as: :buy_ticket_to_event
  get '/user/:uuid/tickets', to: 'events#show_tickets', as: :show_tickets


  get "up" => "rails/health#show", as: :rails_health_check
end
