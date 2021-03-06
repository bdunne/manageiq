module Service::RetirementManagement
  extend ActiveSupport::Concern
  include RetirementMixin

  module ClassMethods
    def retirement_check
      services = Service.where("retires_on IS NOT NULL OR retired = ?", true)
      services.each(&:retirement_check)
    end
  end

  def before_retirement
    services.each(&:retire_now)
    self.service_resources.each do |sr|
      sr.resource.retire_now if sr.resource.respond_to?(:retire_now)
    end
  end

end
