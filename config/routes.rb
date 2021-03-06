Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :canvas, only: [:index, :show, :create, :update]
    end
  end
  mount ActionCable.server => '/cable'
end
