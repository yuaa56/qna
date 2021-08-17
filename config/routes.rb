require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  authenticate :user, lambda {|u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end  
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :questions  do
    resources :comments, shallow: true,  defaults: { commentable: "question" }
    resources :answers, shallow: true do
      resources :comments, shallow: true, defaults: { commentable: "answer" }
    end
    resource :subscription, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
     resources :profiles, only: [:index] do
      get :me, on: :collection 
     end
     resources :questions do 
        resources :answers, shallow: true
     end   
    end  
  end

  root to: "questions#index"
  
  get "users/add_email_form", to: "users#add_email_form", as: :add_email_form
  post "users/add_email", to: "users#add_email", as: :add_user_email

  get "search/", to: "search#index", as: :search
  get '/answers/new(.:format)', to: 'answers#new', as: 'new_answer'
#  get '/users/sign_up(.:format)', to: 'devise/registrations#new', as: 'new_user'
 mount ActionCable.server => '/cable'
end
