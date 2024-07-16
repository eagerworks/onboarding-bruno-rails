class PaymentMethodsController < ApplicationController
  def index
    @payment_methods = PaymentMethod.where(user: current_user)
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    @payment_method.user = current_user
    if @payment_method.save
      redirect_to payment_methods_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.update(payment_method_params)
      redirect_to payment_methods_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.destroy
    redirect_to payment_methods_path
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :owner, :card_number, :due_date, :CVV)
  end
end
