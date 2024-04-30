# ProductAttributeJsonUtility.rb
module ProductAttributeJsonUtility
  
  def add_string_values(row)
    row.each_with_object({}) do |(key, value), hash|
      hash[key] = value if %w[attribute_code store_view_code frontend_input].include?(key)
    end
  end

  def add_attribute_options_values(row)    
    hash = {}
    
    if row["attribute_options"].include?("\n")
      options = row["attribute_options"].split("\n")
    elsif !row["attribute_options"].include?("\n")
      options = row["attribute_options"]
    end

    if options.empty?
      hash["attribute_options"] = []
    elsif options.is_a?(String)
      hash["attribute_options"] = { "label" => options }
    elsif options.is_a?(Array)
      hash["attribute_options"] = options.map { |value| { "label" => value } } 
    end
    
    hash
  end

  def add_inner_hash(row, key)
    inner_hash = {}

    case key
    when "storefront_properties"
      properties = %w[
        is_filterable 
        used_in_product_listing 
        is_filterable_in_search 
        is_visible_on_front 
        position
      ]
    when "admin_properties"
      properties = %w[
        additional_data 
        attribute_set 
        frontend_label 
        is_comparable 
        is_filterable_in_grid 
        is_html_allowed_on_front 
        is_pagebuilder_enabled 
        is_required_in_admin_store 
        is_searchable
        is_used_for_price_rules
        is_used_for_promo_rules
        is_used_in_grid
        is_visible
        is_visible_in_advanced_search
        is_visible_in_grid
        is_wysiwyg_enabled
        search_weight
        used_for_sort_by
      ]
    end
    
    row.each_with_object({}) do |(k, v), hash|
      inner_hash[k] = v if properties.include?(k)
      hash[key] = inner_hash 
    end
  end
end