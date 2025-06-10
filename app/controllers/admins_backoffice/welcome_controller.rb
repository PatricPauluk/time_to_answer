# A linha abaixo foi comentada, pois não deve mais herdar de ApplicationController
# class AdminsBackoffice::WelcomeController < ApplicationController
class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  # Especifica que vai utilizar o layout app/views/layouts/admins_backoffice.html.erb
  # layout 'admins_backoffice'
  # O layout foi especificado novamente em app/controllers/admins_backoffice_controller.rb
  def index
    # busca a quantidade de questões e usuários para a view, através dos Scopes em app/models/admin_statistic.rb
    @total_users = AdminStatistic.total_users
    @total_questions = AdminStatistic.total_questions
  end
end
