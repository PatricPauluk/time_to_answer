# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

# Arquivos em /app/assets devem ser pré-compilados aqui
Rails.application.config.assets.precompile += %w( admins_backoffice.js admins_backoffice.css admin_devise.css admin_devise.js
                                                  users_backoffice.js users_backoffice.css user_devise.css user_devise.js )

# Arquivos em /lib/assets devem ser pré-compilados aqui
Rails.application.config.assets.precompile += %w( color-modes.js dashboard.js dashboard.css dashboard.rtl.css custom.css sign-in.css bootstrap-logo.svg )

# Arquivos em /vendor/assets devem ser pré-compilados aqui
# Rails.application.config.assets.precompile += %w( jquery-2.2.3/dist/jquery.js bootstrap-4.3.1/bootstrap.js bootstrap-4.3.1/bootstrap.css )