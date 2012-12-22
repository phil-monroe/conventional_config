require 'yaml'

module ConventionalConfig
  class Engine < ::Rails::Engine
    
    initializer 'setup_configs' do
      ConventionalConfig.generate!
    end
  end
end
