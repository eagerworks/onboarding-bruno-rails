class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new(purchase_params_with_defaults)
    @purchase.destinations.build
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to confirmation_purchases_path
    else
      flash.now[:alert] = 'No se pudo realizar la compra, revise el formulario.'
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @purchases = Purchase.joins(:payment_method).where(payment_methods: { user: current_user })
                         .includes(:gift)
                         .page(params[:page])
  end

  def show
    @purchase = Purchase.find(params[:id])
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

  def purchase_params_with_defaults
    params.permit(:amount, customization_ids: []).merge(gift: selected_gift,
                                                        payment_method: first_payment_method,
                                                        subtotal:
                                                 params[:price].to_i * selected_amount)
  end
end
