module Classes
  class Filter
    extend ActiveModel::Naming
    attr_accessor :categories_ids # , :orders

    def initialize(categories)
      super()
      @categories_ids = categories || []
      # @orders = orders
    end
  end
end
