# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/images"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/fonts"

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

#stylesheets
Rails.application.config.assets.precompile += %w( vendor.css )
Rails.application.config.assets.precompile += %w( frontend.css )
Rails.application.config.assets.precompile += %w( backend.css )

#javascripts
Rails.application.config.assets.precompile += %w( head.js )
Rails.application.config.assets.precompile += %w( vendor.js )

Rails.application.config.assets.precompile += %w( frontend/frontend_application.js )
Rails.application.config.assets.precompile += %w( frontend/pages/home.js )

Rails.application.config.assets.precompile += %w( backend/backend_application.js )
Rails.application.config.assets.precompile += %w( backend/pages/login.js )
Rails.application.config.assets.precompile += %w( backend/pages/dashboard.js )
Rails.application.config.assets.precompile += %w( backend/pages/pitch_cards.js )
Rails.application.config.assets.precompile += %w( backend/pages/users.js )
Rails.application.config.assets.precompile += %w( backend/shared/upload.js )
