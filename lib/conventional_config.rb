require 'yaml'
require 'erb'
require 'hashie'

require 'conventional_config/config'
require 'conventional_config/engine'


module ConventionalConfig
  def self.generate_classes! paths
    paths.each do |conf_path|
      Dir["#{conf_path}/**.yml"].each do |full_path|
        kname = klass_name(full_path, conf_path)

        if Configs.constants.include? kname
          klass = "ConventionalConfig::Configs::#{kname}".constantize
          klass.path = full_path
        else
          Configs.const_set(kname, Config.new(full_path))
        end

      end
    end


  end

  def self.klass_name(full_path, conf_path)
    name = full_path.gsub(/^#{conf_path}/, '')
    name.gsub!(/^\//, '')
    name.gsub!(/\.yml$/, '')
    name.delete!('.')
    name.camelize.to_sym
  end
end

