# lib/converters/ProductAttributesConverter.rb
class ProductAttributesConverter < BaseConverter
  def initialize(file)
    @data = file.content
    @extension = file.extension
  end

  def data_key
    "customAttributeMetadata"
  end

  def set_csv_headers()
    string_keys = ["attribute_code", "store_view_code", "frontend_input"]
    storefront_keys = @data["items"][0]["storefront_properties"].keys
    admin_keys = @data["items"][0]["admin_properties"].keys    

    string_keys + storefront_keys + admin_keys
  end

  def set_csv_data
    values = []

    @data["items"].each do |item|
      attribute_code = item["attribute_code"]
      store_view_code = item["store_view_code"]
      frontend_input = item["frontend_input"]
      storefront_properties = item["storefront_properties"]
      is_filterable = storefront_properties["is_filterable"]
      used_in_product_listing = storefront_properties["used_in_product_listing"]
      is_filterable_in_search = storefront_properties["is_filterable_in_search"]
      is_visible_on_front = storefront_properties["is_visible_on_front"]
      position = storefront_properties["position"]
      admin_properties = item["admin_properties"]
      additional_data = admin_properties["additional_data"]
      attribute_set = admin_properties["attribute_set"]
      frontend_label = admin_properties["frontend_label"]
      is_comparable = admin_properties["is_comparable"]
      is_filterable_in_grid = admin_properties["is_filterable_in_grid"]
      is_html_allowed_on_front = admin_properties["is_html_allowed_on_front"]
      is_pagebuilder_enabled = admin_properties["is_pagebuilder_enabled"]
      is_required_in_admin_store = admin_properties["is_required_in_admin_store"]
      is_searchable = admin_properties["is_searchable"]
      is_used_for_price_rules = admin_properties["is_used_for_price_rules"]
      is_used_for_promo_rules = admin_properties["is_used_for_promo_rules"]
      is_used_in_grid = admin_properties["is_used_in_grid"]
      is_visible = admin_properties["is_visible"]
      is_visible_in_advanced_search = admin_properties["is_visible_in_advanced_search"]
      is_visible_in_grid = admin_properties["is_visible_in_grid"]
      is_wysiwyg_enabled = admin_properties["is_wysiwyg_enabled"]
      search_weight = admin_properties["search_weight"]
      used_for_sort_by = admin_properties["used_for_sort_by"]

      # Compile values into an array
      value_array = [attribute_code, store_view_code, frontend_input, is_filterable, used_in_product_listing, is_filterable_in_search, is_visible_on_front, position, additional_data, attribute_set, frontend_label, is_comparable, is_filterable_in_grid, is_html_allowed_on_front, is_pagebuilder_enabled, is_required_in_admin_store, is_searchable, is_used_for_price_rules, is_used_for_promo_rules, is_used_in_grid, is_visible, is_visible_in_advanced_search, is_visible_in_grid, is_wysiwyg_enabled, search_weight, used_for_sort_by]
      
      values.push(value_array)
    end

    values
  end

  def convert_csv_to_json()
    csv_to_hash
    convert_values
    build_json
  end

  def convert_json_to_csv()
    string_to_json
    extract_json_body
    pp convert_values
    # build_csv
  end
end
