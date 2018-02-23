class EmbeddedPulpWorker::Runner < MiqWorker::Runner
  def prepare
    ObjectSpace.garbage_collect
    # Overriding prepare so we can set started when we're ready
    do_before_work_loop
    started_worker_record
    self
  end

  def do_before_work_loop
    raise_role_notification(:role_activate_start)
    setup_pulp
    raise_role_notification(:role_activate_success)
  rescue => err
    _log.log_backtrace(err)
    do_exit(err.message, 1)
  end

  def heartbeat
    super if embedded_pulp.alive?
  end

  def do_work
    embedded_pulp.start if !embedded_pulp.alive? && !embedded_pulp.running?
  end

  def before_exit(*_)
    embedded_pulp.disable
  end

  def setup_pulp
    _log.info("Starting embedded pulp service ...")
    embedded_pulp.start
    _log.info("Finished starting embedded pulp service.")
  end

  # Base class methods we override since we don't have a separate process.  We might want to make these opt-in features in the base class that this subclass can choose to opt-out.
  def set_process_title; end
  def set_database_application_name; end
  def set_connection_pool_size; end
  def message_sync_active_roles(*_args); end
  def message_sync_config(*_args); end

  private

  def raise_role_notification(notification_type)
    notification_options = {
      :role_name   => ServerRole.find_by(:name => worker.class.required_roles.first).description,
      :server_name => MiqServer.my_server.name
    }
    Notification.create(:type => notification_type, :options => notification_options)
  end

  def embedded_pulp
    @embedded_pulp ||= EmbeddedPulp.new
  end
end
