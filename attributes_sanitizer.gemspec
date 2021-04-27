$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "attributes_sanitizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attributes_sanitizer"
  s.version     = AttributesSanitizer::VERSION
  s.authors     = ["Anderson Dias"]
  s.email       = ["andersondaraujo@gmail.com"]
  s.homepage    = "https://github.com/andersondias/attributes_sanitizer"
  s.summary     = "Attributes sanitizer for Rails 5+."
  s.description = "A simple way to append sanitizers to attributes on Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.metadata = {
    "changelog_uri"     => "https://github.com/andersondias/attributes_sanitizer/blob/master/CHANGELOG.md",
    "homepage_uri"      => "https://github.com/andersondias/attributes_sanitizer",
    "source_code_uri"   => "https://github.com/andersondias/attributes_sanitizer"
  }

  s.add_dependency "rails", "> 5", "< 7"

  s.add_development_dependency "bootsnap", "~> 1.7"
  s.add_development_dependency "sqlite3", "~> 1.4"
end
