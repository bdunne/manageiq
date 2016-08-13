# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manageiq/gems/pending/version'

Gem::Specification.new do |spec|
  spec.name          = "manageiq-gems-pending"
  spec.version       = Manageiq::Gems::Pending::VERSION
  spec.authors       = ["Brandon Dunne"]
  spec.email         = ["bdunne@redhat.com"]

  spec.summary       = %q{ManageIQ generic helper code pending extraction to external libraries.}
  spec.description   = %q{ManageIQ generic helper code pending extraction to external libraries.}
  spec.homepage      = "http://manageiq.org/"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">=2.2.2"

  # Test dependencies (excluded from the appliance since we don't want to build them)
  spec.add_development_dependency "camcorder"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "jasmine",       "~>2.4.0"
  spec.add_development_dependency "phantomjs",     "=1.9.8.0"
  spec.add_development_dependency "rspec",         "~>3.5.0"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "timecop",       "~>0.7.3"
  spec.add_development_dependency "vcr",           "~>3.0.0"
  spec.add_development_dependency "webmock",       "~>1.12"
  spec.add_development_dependency "xml-simple",    "~>1.1.0"

  # Unmodified gems
  spec.add_runtime_dependency "actionpack",              "~> 5.0.0"
  spec.add_runtime_dependency "activerecord",            "~> 5.0.0" # used by appliance_console
  spec.add_runtime_dependency "activesupport",           "~> 5.0.0"
  spec.add_runtime_dependency "addressable",             "~> 2.4"
  spec.add_runtime_dependency "awesome_spawn",           "~> 1.4"
  spec.add_runtime_dependency "azure-armrest",           "~> 0.3.5"
  spec.add_runtime_dependency "bcrypt",                  "~> 3.1.10"
  spec.add_runtime_dependency "binary_struct",           "~> 2.1"
  spec.add_runtime_dependency "bundler",                 ">= 1.8.4" # rails-assets requires bundler >= 1.8.4, see: https://rails-assets.org/
  spec.add_runtime_dependency "bunny",                   "~>2.1.0"
  spec.add_runtime_dependency "excon",                   "~>0.40"
  spec.add_runtime_dependency "ezcrypto",                "=0.7"
  spec.add_runtime_dependency "ffi",                     "~>1.9.3"
  spec.add_runtime_dependency "ffi-vix_disk_lib",        "~>1.0.2"  # used by VixDiskLib
  spec.add_runtime_dependency "fog-openstack",           "=0.1.11"
  spec.add_runtime_dependency "hawkular-client",         "=2.4.0"
  spec.add_runtime_dependency "httpclient",              "~>2.7.1"
  spec.add_runtime_dependency "image-inspector-client",  "~>1.0.3"
  spec.add_runtime_dependency "iniparse"
  spec.add_runtime_dependency "kubeclient",              "=1.2.0"
  spec.add_runtime_dependency "linux_admin",             "~>0.17.0"
  spec.add_runtime_dependency "log4r",                   "=1.1.8"
  spec.add_runtime_dependency "memoist",                 "~>0.14.0"
  spec.add_runtime_dependency "memory_buffer",           ">=0.1.0"
  spec.add_runtime_dependency "more_core_extensions",    "~>3.1.0"
  spec.add_runtime_dependency "net-scp",                 "~>1.2.1"
  spec.add_runtime_dependency "net-sftp",                "~>2.1.2"
  spec.add_runtime_dependency "nokogiri",                "~>1.6.8"
  spec.add_runtime_dependency "openscap",                "~>0.4.3"
  spec.add_runtime_dependency "openshift_client",        "=1.2.0"
  spec.add_runtime_dependency "ovirt",                   "~>0.11.0"
  spec.add_runtime_dependency "pg",                      "~>0.18.2"
  spec.add_runtime_dependency "pg-dsn_parser",           "~>0.1.0"
  spec.add_runtime_dependency "psych",                   "~>2.0.12"
  spec.add_runtime_dependency "rake",                    "~>10.1"
  spec.add_runtime_dependency "rbvmomi",                 "~>1.8.0"
  spec.add_runtime_dependency "rest-client",             "~>2.0.0"
  spec.add_runtime_dependency "rubyzip",                 "~>1.2.0"
  spec.add_runtime_dependency "rufus-lru",               "~>1.0.3"
  spec.add_runtime_dependency "sys-proctable",           "~>1.1.0"
  spec.add_runtime_dependency "sys-uname",               "~>1.0.1"
  spec.add_runtime_dependency "trollop",                 "~>2.0"
  spec.add_runtime_dependency "uuidtools",               "~>2.1.3"
  spec.add_runtime_dependency "winrm",                   "~>1.7.2"
  spec.add_runtime_dependency "winrm-elevated",          "~>0.4.0"
  spec.add_runtime_dependency "zip-zip",                 "~>0.3.0"
end
