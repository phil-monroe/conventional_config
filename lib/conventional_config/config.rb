module ::ConventionalConfig
  class Config
    attr_accessor :path

    def initialize path
      self.path = path
    end

    def load_config!
      yaml = ERB.new(File.read(path)).result
      hash = YAML.load yaml
      ::Hashie::Mash.new hash
    end

    def full
      @full ||= load_config!
    end

    def config
      @config ||= if defined?(Rails) && !full[Rails.env].nil?
        full[Rails.env]
      else
        full
      end
    end

    def config= conf
      @config = conf
    end

    def method_missing(meth, *args, &block)
      config.send(meth, *args, &block)
    end
  end


  module Configs
    # namespace for holding configs
  end
end