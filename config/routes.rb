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
    get 'archived_lists', to: 'task_lists#archived'
  end

  get 'api_token', to: 'users#token'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        resources :task_lists, only: [:index, :show]
        resources :tasks, only: [:index, :show]
      end
    end
  end
end
