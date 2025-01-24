# A linha abaixo foi comentada, pois não deve mais herdar de ApplicationController
# class ProfilesBackoffice::WelcomeController < ApplicationController
class ProfilesBackoffice::WelcomeController < ProfilesBackofficeController
  # Especifica que vai utilizar o layout app/views/layouts/profiles_backoffice.html.erb
  # layout 'profiles_backoffice'
  # O layout foi especificado novamente em app/controllers/profiles_backoffice_controller.rb
  def index
  end
end
