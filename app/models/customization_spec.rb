class CustomizationSpec < ActiveRecord::Base
  belongs_to :ext_management_system, :foreign_key => "ems_id"

  serialize :spec

  def is_sysprep_spec?
    self[:spec].fetch_path(['identity', 'value']).nil?
  end

  def is_sysprep_file?
    !is_sysprep_spec?
  end

  def to_hash_struct
    new_hs = MiqHashStruct.new(:evm_object_class => :CustomizationSpec)
    [:id, :name, :typ, :description, :last_update_time, :is_sysprep_spec?].each_with_object(new_hs) { |i, hs| hs.send("#{i}=", send(i)) }
  end
end
