# A linha abaixo foi comentada, pois não deve mais herdar de ApplicationController
# class AdminsBackoffice::WelcomeController < ApplicationController
class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  # Especifica que vai utilizar o layout app/views/layouts/admins_backoffice.html.erb
  # layout 'admins_backoffice'
  # O layout foi especificado novamente em app/controllers/admins_backoffice_controller.rb
  def index
    # find_by_event, pois event é o nome do campo no active record, assim é retornada uma busca para exibir na view
    @total_users = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_users]).value
    @total_questions = AdminStatistic.find_by_event(AdminStatistic::EVENTS[:total_questions]).value
  end
end
