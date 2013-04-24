$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conventional_config/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conventional_config"
  s.version     = ConventionalConfig::VERSION
  s.authors     = ["Phil Monroe"]
  s.email       = ["phil@philmonroe.com"]
  s.homepage    = "https://github.com/phil-monroe/conventional_config"
  s.summary     = "Better Rails Configuration"
  s.description = "Better Rails Configuration by auto generating classes to represent YAML configs"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency "hashie"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
