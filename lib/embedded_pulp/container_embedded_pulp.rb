class ContainerEmbeddedPulp < EmbeddedPulp
  PULP_SERVICE_NAME = "pulp".freeze

  def self.available?
    return true
    ContainerOrchestrator.available?
  end

  def start
    create_pulp_service
    create_pulp_persistent_volume_claim
    create_pulp_deployment_config
    create_pulp_route

    loop do
      break if alive?

      _log.info("Waiting for Pulp container to respond")
      sleep WAIT_FOR_PULP_SLEEP
    end
  end

  def stop
    orchestrator.delete_deployment_config(PULP_SERVICE_NAME)
    orchestrator.delete_route
    orchestrator.delete_service(PULP_SERVICE_NAME)
  end

  alias disable stop

  def running?
    true
  end

  def configured?
    true
  end

  private

  def create_pulp_route
    orchestrator.create_route(PULP_SERVICE_NAME) do |route|
      route.store_path(:spec, :tls, :termination, "passthrough")
    end
  end

  def create_pulp_service
    orchestrator.create_service(PULP_SERVICE_NAME, 443)
  end

  def create_pulp_deployment_config
    orchestrator.create_deployment_config(PULP_SERVICE_NAME) do |dc|
      dc[:spec][:serviceName] = PULP_SERVICE_NAME
      dc[:spec][:replicas] = 1

      dc[:spec][:template][:spec][:serviceAccount]     = settings.service_account
      dc[:spec][:template][:spec][:serviceAccountName] = settings.service_account

      dc.store_path(:spec, :template, :spec, :volumes, [{:name => "#{PULP_SERVICE_NAME}-volume", :persistentVolumeClaim => {:claimName => "#{PULP_SERVICE_NAME}-volume"}}])

      container = dc[:spec][:template][:spec][:containers].first
      container.delete(:livenessProbe)
      container[:ports]          = [{:containerPort => 443}]
      container[:readinessProbe] = readiness_probe
      container[:image]          = image
      container[:volumeMounts]   = [{:name => "#{PULP_SERVICE_NAME}-volume", :mountPath => "/pv"}]
    end
  end

  def create_pulp_persistent_volume_claim
    orchestrator.create_persistent_volume_claim(PULP_SERVICE_NAME, "10Gi")
  end

  def readiness_probe
    {
      :httpGet             => {:path => "/", :port => 443, :scheme => "HTTPS"},
      :initialDelaySeconds => 20,
      :timeoutSeconds      => 3
    }
  end

  def image
    "#{settings.image_name}:#{settings.image_tag}"
  end

  def orchestrator
    @orchestrator ||= ContainerOrchestrator.new
  end

  def settings
    ::Settings.embedded_pulp.container
  end
end
