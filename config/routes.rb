Rails.application.routes.draw do
  get 'task_lists/index'

  get 'task_lists/show'

  get 'task_lists/archived'

  get 'task_lists/edit'

  root 'task_lists#index'

  get 'login', to: 'sessions#new'
  post 'sessions/create'
  delete 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'users/create'
end
