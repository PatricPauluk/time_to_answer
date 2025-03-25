class ApplicationController < ActionController::Base
    layout :layout_by_resource

    protected
    
    # devise_controller? verifica se o controller atual pertence ao devise
    # resource_class verifica qual classe de devise o controller atual pertence (Admin ou User)
    def layout_by_resource
        if devise_controller? && resource_class == Admin
            "admin_devise"
        else
            "application"
        end
    end
end
