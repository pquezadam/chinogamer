class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(product: @product, user: current_user)
    if @order.save
      redirect_to products_path, notice: 'la orden ha sido ingresada'
    else
      redirect_to product_path, alert: 'la orden no ha sido ingresada'
    end
  end

  def clean
    @orders = Order.where(user: current_user, payed: false)
    @orders.destroy_all
    redirect_to orders_path, notice: 'carro vacío. '
  end

  def index
    @orders = current_user.orders
  end
end




