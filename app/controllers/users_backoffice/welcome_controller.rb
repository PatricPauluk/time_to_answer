# A linha abaixo herdava de ApplicationController, agora herda de UsersBackofficeController
class UsersBackoffice::WelcomeController < UsersBackofficeController
  # O layout foi especificado novamente em app/controllers/users_backoffice_controller.rb
  def index
  end
end