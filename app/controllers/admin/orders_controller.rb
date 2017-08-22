class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all.order("id DESC")
  end

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  def cancel
    @order = Order.find_by_token(params[:id])
    @order.cancel_order!
    OrderMailer.notify_admin_cancel(@order).deliver!

    redirect_to admin_order_path(@order.token), notice: "已取消订单。"
  end

  def shipping
    @order = Order.find_by_token(params[:id])
    @order.ship!
    OrderMailer.notify_shipping(@order).deliver!

    redirect_to admin_order_path(@order.token), notice: "已出货。"
  end

end
