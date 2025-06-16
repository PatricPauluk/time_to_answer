class AdminsBackoffice::AdminsController < AdminsBackofficeController
  # Before action executa as funções antes das actions especificadas
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]

  # OBS: As funções abaixo são chamadas de ACTION

  def index
    # @admins = Admin.all
    # Código abaixo utilizando Kaminari para paginação
    @admins = Admin.all.page(params[:page]).per(10)
  end

  def new
    @admin = Admin.new
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador excluído com sucesso!"
    else
      render :index
    end
  end

  def create
    # Cria um admin recebendo os parâmetros
    @admin = Admin.new(params_admin)
    # A action de criar usuário é muito semelhante com a de atualizar
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador criado com sucesso!"
    else
      # Caso não der certo, volta para a página new
      render :new
    end
  end

  def edit
  end
  
  def update
    if @admin.update(params_admin)
      # Envia um email para o admin informando que seus dados foram alterados
      # O current_admin é o admin que está logado, e @admin é o admin que foi atualizado
      # O método deliver_now envia o email imediatamente
      AdminMailer.update_email(current_admin, @admin).deliver_now
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