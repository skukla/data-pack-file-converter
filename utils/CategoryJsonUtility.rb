# ProductAttributeJsonUtility.rb
module CategoryJsonUtility
  
  def extract_category_fields
    headers = set_csv_headers
    @data.map! do |hash|
      hash.select { |key, _| headers.include?(key) }
    end
  end

  def construct_category_paths
    @data.each do |hash|
      next unless hash["url_path"]
      
      path_segments = hash["url_path"].split("/").map do |slug|
        category = @data.find { |h| h["url_key"] == slug }
        category["name"] if category
      end.compact
      
      hash["path"] = path_segments.empty? ? "" : path_segments.join("/")
      hash.delete("url_path")
    end
  end

  def resort_categories
    sorted_hashes = []

    @data.each do |hash|
      sorted_hashes << hash
      sorted_hashes += children_of(hash) if has_children?(hash)
    end

    @data = sorted_hashes.uniq { |hash| hash["name"] }
  end

  private

  def children_of(parent_hash)
    @data.select { |hash| child_of_parent?(hash, parent_hash) }.sort_by { |hash| hash["position"] }
  end

  def child_of_parent?(hash, parent_hash)
    hash["path"].start_with?(parent_hash["path"] + "/") if parent_hash["path"]
  end

  def has_children?(parent_hash)
    @data.any? { |hash| child_of_parent?(hash, parent_hash) }
  end

  public

  def reshape_category_hashes
    extract_category_fields
    construct_category_paths
    resort_categories
  end
end