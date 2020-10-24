Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :canvas, only: [:show, :create, :update]
    end
  end
  mount ActionCable.server => '/cable'
end