class ProfilesBackofficeController < ApplicationController
  # Especifica que vai proteger todo controller que herdar deste controller (no caso, a pasta app/controllers/profiless_backoffice)
  before_action :authenticate_profile!
  
  # Especifica que vai utilizar o layout app/views/layouts/profiles_backoffice.html.erb
  layout 'profiles_backoffice'
end
