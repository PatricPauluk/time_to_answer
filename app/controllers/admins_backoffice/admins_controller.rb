class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    # Recebe por parâmetro o ID de um admin e busca-o no banco de dados
    @admin = Admin.find(params[:id])
  end
end