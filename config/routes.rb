Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :questions  do
    resources :answers, shallow: true
  end
  root to: "questions#index"
  
 # get '/answers/:id', to: 'answers#show', as: 'answer'
#  get '/questions/:question_id/answers/new(.:format)', to: 'answers#new', as: 'new_question_answer1'
  get '/answers/new(.:format)', to: 'answers#new', as: 'new_answer'
#  get '/users/sign_up(.:format)', to: 'devise/registrations#new', as: 'new_user'
end
