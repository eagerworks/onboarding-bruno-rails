class GiftsController < ApplicationController
  def index
    @gifts = Gift.order(:name).page(params[:page])
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :valoration, :price, :supplier_id, :image)
  end
end
