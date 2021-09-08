class Public::OrdersController < ApplicationController

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0

    @order.save
     @cart_item = current_customer.cart_items
      @cart_item.each do |cart_item|
        @order_detail = OrderDetail.new({
          item_id: cart_item.item_id,
          order_id: @order.id,
          price: cart_item.item.price,
          amount: cart_item.amount,
          making_status: 0
        })
        @order_detail.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path

  end

  def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i

    @order = Order.new(order_params)
    @cart_item = CartItem.all
    @address = Address.find(params[:order][:address_id])

    if params[:order][:address_option] == "1"
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:address_option] == "2"
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
    else params[:order][:address_option] == "3"
      @address = Address.new
      @address.postal_code = params[:order][:postal_code]
      @address.name = params[:order][:name]
      @address.address = params[:order][:address]
      @address.save
       @order.address = @address.address
       @order.name = @address.name
       @order.postal_code = @address.postal_code
    end
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:name, :image, :address, :postal_code, :introduction, :price, :is_active, :total_payment, :genre_id, :status, :payment_method)
  end

end
