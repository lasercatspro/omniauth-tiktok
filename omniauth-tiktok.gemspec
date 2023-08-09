# -*- encoding: utf-8 -*-
# stub: omniauth-tiktok 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-tiktok".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://github.com/Lianowar/omniauth-tiktok", "source_code_uri" => "https://github.com/Lianowar/omniauth-tiktok" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["novikov.vasiliy".freeze]
  s.bindir = "exe".freeze
  s.date = "2023-08-08"
  s.email = ["novikov.vasiliy.d@gmail.com".freeze]
  s.files = [".github/workflows/specs.yml".freeze, ".gitignore".freeze, ".rspec".freeze, ".rubocop.yml".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/omniauth-tiktok.rb".freeze, "lib/omniauth-tiktok/version.rb".freeze, "lib/omniauth/strategies/tiktok.rb".freeze, "omniauth-tiktok.gemspec".freeze]
  s.homepage = "https://github.com/Lianowar/omniauth-tiktok".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "Tiktok OAuth2 Strategy for OmniAuth".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<omniauth>.freeze, [">= 1.9", "< 3"])
    s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
  else
    s.add_dependency(%q<omniauth>.freeze, [">= 1.9", "< 3"])
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
  end
end
