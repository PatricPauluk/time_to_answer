class UsersBackofficeController < ApplicationController
  # Especifica que vai proteger todo controller que herdar deste controller (no caso, a pasta app/controllers/users_backoffice)
  before_action :authenticate_user!
  
  # "Monta" o perfil do usuário, para caso o envio de uma nova foto no modal de users_backoffice não carregue
  before_action :build_profile

  # Especifica que vai utilizar o layout app/views/layouts/users_backoffice.html.erb
  layout 'users_backoffice'

  private

  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end
end
