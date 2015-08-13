class WindowsImage < ActiveRecord::Base
  belongs_to :pxe_server
  belongs_to :pxe_image_type

  has_many :customization_templates, :through => :pxe_image_type

  def to_hash_struct
    new_hs = MiqHashStruct.new(:evm_object_class => :WindowsImage)
    [:id, :name, :description].each_with_object(new_hs) { |i, hs| hs.send("#{i}=", send(i)) }
  end
end
