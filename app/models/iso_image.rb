class IsoImage < ActiveRecord::Base
  belongs_to :iso_datastore
  belongs_to :pxe_image_type

  has_many :customization_templates, :through => :pxe_image_type

  def to_hash_struct
    MiqHashStruct.new(:evm_object_class => :IsoImage, :id => "#{IsoImage}::#{id}", :name => name)
  end
end
