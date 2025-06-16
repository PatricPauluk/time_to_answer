class ApplicationController < ActionController::Base
    layout :layout_by_resource
    before_action :check_pagination
    before_action :set_global_params

    protected
    
    # devise_controller? verifica se o controller atual pertence ao devise
    # resource_class verifica qual classe de devise o controller atual pertence (admin ou user) ...
    # ... e retorna o layout correspondente
    def layout_by_resource
        devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "application"
    end

    # Remove o parâmetro page caso o usuário não esteja logado, para ver as outras questões
    def check_pagination
        unless user_signed_in?
            params.extract!(:page)
        end
    end

    # Define os parâmetros globais para serem acessados em qualquer lugar da aplicação
    def set_global_params
        $global_params = params
    end
end
