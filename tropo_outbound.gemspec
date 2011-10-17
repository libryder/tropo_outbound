GEM_FILES = %w{
  tropo_outbound.gemspec
  lib/tropo_outbound.rb
  tropo_outbound.yml
}

Gem::Specification.new do |s|
  s.name = "tropo_outbound"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Ryder"]

  s.date = Date.today.to_s
  s.description = "Outbound dialing component using Tropo AGItate."
  s.email = "me@libryder.com"

  s.files = GEM_FILES

  s.has_rdoc = false
  s.homepage = "http://libryder.com"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.2.0"
  s.summary = "Outbound dialing component using Tropo AGItate."

  s.specification_version = 2
end
