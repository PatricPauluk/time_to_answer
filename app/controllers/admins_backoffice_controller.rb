class AdminsBackofficeController < ApplicationController
  # Especifica que vai proteger todo controller que herdar deste controller (no caso, a pasta app/controllers/admins_backoffice)
  before_action :authenticate_admin!

  # Especifica que vai utilizar o layout app/views/layouts/admins_backoffice.html.erb
  layout 'admins_backoffice'
end
