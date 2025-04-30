class UsersBackoffice::ProfileController < UsersBackofficeController
    before_action :verify_password, only:[:update]
    before_action :set_user

    def edit
        # Gera os campos de perfil do usuário se estiver em branco
        @user.build_user_profile if @user.user_profile.blank?
    end

    def update
        if @user.update(params_user)
            bypass_sign_in(@user) # não desloga usuário ao alterar a senha
            redirect_to users_backoffice_profile_path, notice: "Usuário atualizado com sucesso."
        else
            render :edit
        end
    end

    private

    def set_user
        @user = User.find(current_user.id)
    end

    def params_user
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
        user_profile_attributes: [:id, :address, :gender, :birthdate])
    end

    def verify_password
        # Caso os campos de senha e confirmação de senha não forem preenchidos, remove as chaves deles de params
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].extract!(:password, :password_confirmation)
        end
    end
end
