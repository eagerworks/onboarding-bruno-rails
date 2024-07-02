class GiftsController < ApplicationController
  before_action :classes_filter, :load_filters_and_categories, only: [:index]
  def index
    query_categories = if selected_categories.empty?
                         @categories.map(&:id)
                       else
                         selected_categories
                       end
    query = Gift.get_gifts_from_categories(query_categories, selected_order)
    @query_count = query.count
    @gifts = query.page(params[:page])
  end

  private

  def load_filters_and_categories
    @categories = Category.all
    @filters = Classes::Filter.new(selected_categories, selected_order)
  end

  def selected_categories
    classes_filter&.dig(:categories_ids)&.map!(&:to_i) || []
  end

  def selected_order
    classes_filter&.dig(:order) || 'name'
  end

  def classes_filter
    params[:classes_filter]
  end
end
