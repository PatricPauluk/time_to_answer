class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: [:edit, :update]

  def index
    @admins = Admin.all
  end

  def edit
  end
  
  def update
    # Por enquanto, ao atualizar os dados de usuário PRECISAMOS informar login e senha, mas será consertado.
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
    else
      render :edit
    end
  end
  
  # ----------------------------------------------------------------------------------------------------------------------------
  private

  def params_admin
    # O require é necessário para permitir as chaves: email, password e senha, pois estão dentro de admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def verify_password
    # Caso os campos de senha e confirmação de senha não forem preenchidos, remove as chaves deles, possibilitanto atualizar só o email
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

  def set_admin
    # Recebe por parâmetro o ID de um admin e busca-o no banco de dados
    @admin = Admin.find(params[:id])
  end
end