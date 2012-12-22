require 'yaml'
require 'erb'

require 'conventional_config/settings'
require 'conventional_config/engine'


module ConventionalConfig
  DEFAULT_FOLDER = 'settings'

  class << self

    def generate!
      Dir["#{conf_path}/#{settings_folder}/**/**.yml"].each do |yaml_file|
        puts yaml_file
        generate_class yaml_file
      end
    end
    
    def generate_class file
      settings = Settings.new(YAML::load(ERB.new(File.read(file)).result(binding)))
      const_name = File.basename(file).gsub(/\.yml/, "").classify
        
      self.class_eval do
        const_set const_name, settings 
      end
    end
    
    

    def settings_folder= name
      @settings_folder = name
    end

    def settings_folder
      @settings_folder ||= DEFAULT_FOLDER
    end
    
    def aliases *args
      args.each do |arg|
        Kernel.const_set arg.classify, self
      end
    end

    def conf_path
      @conf_path ||= Rails.application.config.paths['config'].expanded.first
    end
  end
end

