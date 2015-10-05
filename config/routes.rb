Rails.application.routes.draw do
  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'sessions/create'
  delete 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  resources :users, only: [:create] do
    resources :task_lists do
      patch "tasks/:id/complete", to: 'tasks#complete', as: 'complete_task'
      patch "tasks/:id/uncomplete", to: 'tasks#uncomplete', as: 'uncomplete_task'
      resources :tasks, only: [:new, :create, :destroy, :edit, :update]
    end
    get 'task_lists/:id/completed', to: 'task_lists#completed', as: 'task_list_completed'
    get 'archived_lists', to: 'task_lists#archived'
  end
end
