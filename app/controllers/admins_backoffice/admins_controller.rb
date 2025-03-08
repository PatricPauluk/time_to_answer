class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    # Recebe por parâmetro o ID de um admin e busca-o no banco de dados
    @admin = Admin.find(params[:id])
  end
  
  def update
    admin = Admin.find(params[:id])

    # O require é necessário para permitir as chates: email, password e senha, pois estão dentro de admin
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)

    # Por enquanto, ao atualizar os dados de usuário PRECISAMOS informar login e senha, mas será consertado.
    if admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
    else
      render :edit
    end
  end
end