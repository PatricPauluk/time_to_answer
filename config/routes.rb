Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    # rota search que chama o controller search e a action questions
    get 'search', to: 'search#questions'
    # roda seach_subject com parâmetros que chama o controller search e a action subject
    get 'search_subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    # rota answer que chama o controller answer e a action question
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do # referente a app/controllers/admins_backoffice
    get 'welcome/index' # Dashboard
    # resources :admins, only: [:index, :edit, :update, :new] # cria os helpers de crud, mas especifica apenas o necessário
    # resources :admins, except: [:delete] # cria os helpers de crud, menos delete
    resources :admins # cria os helpers de crud para admins
    resources :subjects
    resources :questions
  end

  # skip: [registrations] remove a possibilidade de criar um usuário sem estar logado
  devise_for :admins, skip: [:registrations]
  devise_for :users

  # Mapeamento, traduzindo o caminho de site/welcome#index como inicio.
  # Acessa como: http://localhost:3000/inicio
  get 'inicio', to: 'site/welcome#index'

  # Define a rota padrão para Welcome Index
  root to: 'site/welcome#index' # nome_controler#pagina

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
