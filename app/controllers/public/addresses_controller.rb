class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all.order(created_at: :asc)
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to book_path(@book)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end


end
