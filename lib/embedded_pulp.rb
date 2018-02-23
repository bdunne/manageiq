class EmbeddedPulp
  include Vmdb::Logging

  PULP_ROLE           = "embedded_pulp".freeze
  WAIT_FOR_ANSIBLE_SLEEP = 1.second

  def self.new
    self == EmbeddedPulp ? detect_available_platform.new : super
  end

  def self.detect_available_platform
    ContainerEmbeddedPulp
  end

  def self.available?
    true
  end

  def self.enabled?
    MiqServer.my_server(true).has_active_role?(PULP_ROLE)
  end

  def alive?
    return false unless configured? && running?
    true
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "embedded_pulp/*.rb")).each { |f| require_dependency f }
