Rails.application.routes.draw do
  namespace :admins_backoffice do # referente a app/controllers/admins_backoffice
    get 'admins/index'
    # get 'admins/edit/:id' to: 'admins#edit' # referente app/controllers/admins_backoffice/admins_controller.rb || e a açõo de edit
    resources :admins, only: [:index] # cria os helpers de crud, mas especifica apenas o index
  end
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
  end
  devise_for :admins
  devise_for :users

  # Mapeamento, traduzindo o caminho de site/welcome#index como inicio.
  # Acessa como: http://localhost:3000/inicio
  get 'inicio', to: 'site/welcome#index'

  # Define a rota padrão para Welcome Index
  root to: 'site/welcome#index' # nome_controler#pagina

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
