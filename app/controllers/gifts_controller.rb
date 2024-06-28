class GiftsController < ApplicationController
  def index
    @categories = Category.all
    @filters = Classes::Filter.new(selected_categories)
    query = Gift.joins(:gift_categorizations)
    unless selected_categories.empty?
      query = query.where(gift_categorizations: { category_id: selected_categories })
    end
    @gifts = query.order(:price).page(params[:page])
  end

  private

  def selected_categories
    if params[:classes_filter].nil?
      []
    else
      params[:classes_filter][:categories_ids].map!(&:to_i)
    end
  end

  def gift_params
    params.require(:gift).permit(:name, :valoration, :price, :supplier_id, :image)
  end
end
