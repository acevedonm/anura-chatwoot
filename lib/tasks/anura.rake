namespace :anura do
  desc 'Apply the fork branding to an existing installation without changing other settings'
  task branding: :environment do
    names = %w[INSTALLATION_NAME LOGO LOGO_DARK LOGO_THUMBNAIL]

    InstallationConfig.transaction do
      ConfigLoader.new.general_configs.select { |config| names.include?(config['name']) }.each do |config|
        setting = InstallationConfig.find_or_initialize_by(name: config['name'])
        setting.update!(value: config['value'])
      end
    end

    puts 'Anura Connect branding applied.'
  end
end
