# A linha abaixo herdava de ApplicationController, agora herda de UsersBackofficeController
class UsersBackoffice::WelcomeController < UsersBackofficeController
  # O layout foi especificado novamente em app/controllers/users_backoffice_controller.rb
  def index
    @user_statistic = UserStatistic.find_or_create_by(user: current_user)
  end
end