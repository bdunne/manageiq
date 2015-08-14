module CloudInitTemplateMixin
  def allowed_cloud_init_customization_templates(options={})
    customization_template_id = get_value(@values[:customization_template_id])
    @values[:customization_template_script] = CustomizationTemplateCloudInit.where(:id => customization_template_id).first.script
    CustomizationTemplateCloudInit.all.collect(&:to_hash_struct).compact
  end
end
