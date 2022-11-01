module Ebay
  class Category < Resource
    include Ebay::ResourceActions.new uri: 'commerce/taxonomy/v1/category_tree/%s'

    def self.get_default_category_tree_id(params)
      get 'commerce/taxonomy/v1/get_default_category_tree_id', params
    end

    def self.get_aspects(category_tree_id, params)
      get "#{path.build(category_tree_id)}/get_item_aspects_for_category", params
    end
  end
end
