class TreeBuilderChargebackRates < TreeBuilder

  private

  def tree_init_options(tree_name)
   {:open_all => true, :full_ids => true, :leaf => "MiqReportResult"}
  end

  def set_locals_for_render
    locals = super
    temp = {
      :id_prefix      => "cbr_",
    }
    locals.merge!(temp)
  end

  # Get root nodes count/array for explorer tree
  def x_get_tree_roots(options)
    count_only = options[:count_only]
    #TODO: Common code in CharbackRate & ChargebackAssignments, need to move into module
    case options[:type]
    when :cb_assignments, :cb_rates
      rates = ChargebackRate.all
      rate_types = rates.collect(&:rate_type).uniq.sort

      if count_only
        rate_types.length
      else
        objects = []
        rate_types.sort.each do |rtype|
          img = rtype.downcase == "compute" ? "hardware-processor" : "hardware-disk"
          objects.push(
                        :id     => rtype,
                        :text   => rtype,
                        :image  => img,
                        :tip    => rtype
          )
        end
        objects
      end
    end
  end

  # Handle custom tree nodes (object is a Hash)
  def x_get_tree_custom_kids(object, options)
    count_only = options[:count_only]
    objects = ChargebackRate.all(:conditions => ["rate_type = ?",object[:id]])
    count_only_or_objects(options[:count_only], objects, "description")
  end
end
