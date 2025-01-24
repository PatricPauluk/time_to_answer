Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
  end
  namespace :profiles_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
  end
  devise_for :profiles
  devise_for :admins

  # Mapeamento, traduzindo o caminho de site/welcome#index como inicio.
  # Acessa como: http://localhost:3000/inicio
  get 'inicio', to: 'site/welcome#index'

  # Define a rota padrão para Welcome Index
  root to: 'site/welcome#index' # nome_controler#pagina

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
