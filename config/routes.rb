Rails.application.routes.draw do
  resources :tasks
  # Overriding default devise controller
  devise_for :users, controllers: { registrations: "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/complete/:id', to: 'tasks#complete', as: 'complete'
  
  root "tasks#index"
end
