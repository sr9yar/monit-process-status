Rails.application.routes.draw do
  root 'main#index'
  get 'main/index'

  get 'main/start'
  get 'main/stop'
  get 'main/status'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
