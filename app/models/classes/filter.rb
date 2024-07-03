module Classes
  class Filter
    extend ActiveModel::Naming
    attr_reader :categories_ids, :order

    def initialize(categories, order)
      super()
      @categories_ids = categories
      @order = order
    end
  end
end
