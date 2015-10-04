Rails.application.routes.draw do
  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'sessions/create'
  delete 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  resources :users, only: [:create] do
    resources :task_lists
    get 'archived_lists', to: 'task_lists#archived'
  end
end
