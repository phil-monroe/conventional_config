module ConventionalConfig
  class Settings
    attr_reader :settings, :file_path
    
    include Comparable

    def initialize settings
      @settings = settings 
      
      if @settings.is_a? Hash
        @settings = HashWithIndifferentAccess.new(settings)
        @settings.each do |k, v|
          
          self.class_eval do
            define_method(k.to_sym) do
              Settings.new(v)
            end
          end
        end
      end
    end
    
    def inspect
      settings.inspect
    end
    
    def method_missing meth, *args
      settings.send(meth, *args)
    end
    
    def <=> other
      settings <=> other
    end
  end
end