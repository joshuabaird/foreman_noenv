module ForemanNoenv
  class Engine < ::Rails::Engine
    engine_name 'foreman_noenv'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_noenv.load_app_instance_data' do |app|
      ForemanNoenv::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_noenv.register_plugin', after: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_noenv do
        requires_foreman '>= 1.8'
      end
    end

    # Precompile any JS or CSS files under app/assets/
    # If requiring files from each other, list them explicitly here to avoid precompiling the same
    # content twice.
    assets_to_precompile =
      Dir.chdir(root) do
        Dir['app/assets/javascripts/**/*', 'app/assets/stylesheets/**/*'].map do |f|
          f.split(File::SEPARATOR, 4).last
        end
      end
    initializer 'foreman_noenv.assets.precompile' do |app|
      app.config.assets.precompile += assets_to_precompile
    end
    initializer 'foreman_noenv.configure_assets', group: :assets do
      SETTINGS[:foreman_noenv] = { assets: { precompile: assets_to_precompile } }
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanNoenv::HostManagedExtensions)
      rescue => e
        Rails.logger.warn "ForemanNoenv: skipping engine hook (#{e})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanNoenv::Engine.load_seed
      end
    end

    initializer 'foreman_noenv.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_noenv'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
