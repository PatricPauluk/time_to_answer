Rails.application.routes.draw do
  get 'welcome/index'

  # Mapeamento, traduzindo o caminho de welcome#index como inicio.
  # Acessa como: http://localhost:3000/inicio
  get 'inicio', to: 'welcome#index'

  # Define a rota padrão para Welcome Index
  root to: 'welcome#index' # nome_controler#pagina

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
