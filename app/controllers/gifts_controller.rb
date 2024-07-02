class GiftsController < ApplicationController
  before_action :load_filters_and_categories, only: [:index]
  def index
    query = Gift.joins(:gift_categorizations)
    unless selected_categories.empty?
      query = query.where(gift_categorizations: { category_id: selected_categories })
    end
    query = query.order(selected_order)
    @options = query.count
    @gifts = query.page(params[:page])
  end

  private

  def load_filters_and_categories
    @categories = Category.all
    @filters = Classes::Filter.new(selected_categories, selected_order)
  end

  def selected_categories
    if params[:classes_filter].nil? || params[:classes_filter][:categories_ids].nil?
      []
    else
      params[:classes_filter][:categories_ids].map!(&:to_i)
    end
  end

  def selected_order
    if params[:classes_filter].nil?
      'name'
    else
      params[:classes_filter][:order]
    end
  end

  def gift_params
    params.require(:gift).permit(:name, :valoration, :price, :supplier_id, :image)
  end
end
