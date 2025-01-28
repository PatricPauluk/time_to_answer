class UsersBackofficeController < ApplicationController
  # Especifica que vai proteger todo controller que herdar deste controller (no caso, a pasta app/controllers/users_backoffice)
  before_action :authenticate_user!
  
  # Especifica que vai utilizar o layout app/views/layouts/users_backoffice.html.erb
  layout 'users_backoffice'
end
