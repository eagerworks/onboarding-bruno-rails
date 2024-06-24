class GiftsController < ApplicationController
  def index
    @gifts = Gift.all
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :valoration, :price, :supplier_id, :image)
  end
end
