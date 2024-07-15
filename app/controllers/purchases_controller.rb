class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new(gift: selected_gift,
                             payment_method: first_payment_method,
                             amount: selected_amount,
                             customization_ids: params[:customizations_ids],
                             subtotal: params[:price].to_i * selected_amount)
    @purchase.destinations.build
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to root_path
    else
      flash.now[:alert] = 'No se pudo realizar la compra, revise el formulario.'
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def selected_amount
    params[:amount].to_i
  end

  def selected_gift
    Gift.find(params[:gift_id])
  end

  def first_payment_method
    PaymentMethod.where(user: current_user).first
  end

  def purchase_params
    params.require(:purchase).permit(:subtotal, :company_logo, :amount, :gift_id,
                                     :payment_method_id,
                                     :suprise_delivery, :personalization, :resend_delivery,
                                     :RUT, :social_reason, :price, customization_ids: [],
                                                                   destinations_attributes:
                                                                   [:receiver, :day,
                                                                    :address, :number,
                                                                    :cost, :schedules])
  end
end
