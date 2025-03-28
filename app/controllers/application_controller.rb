class ApplicationController < ActionController::Base
    layout :layout_by_resource

    protected
    
    # devise_controller? verifica se o controller atual pertence ao devise
    # resource_class verifica qual classe de devise o controller atual pertence (admin ou user) ...
    # ... e retorna o layout correspondente
    def layout_by_resource
        devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "application"
    end
end
