# config/initializers/app_settings.rb
# ========================
# Tells Rails to load our AppSettings module and then
# populates our config class variable with data from our application_settings.yml file
# From here on in, we should be able to call:
#
#    AppSettings.config['email_notifications']
#
# and have it return our config option...

require "#{Dir.pwd}/lib/app_settings.rb"
AppSettings.config = YAML.load_file("config/settings.yml")[Rails.env]
