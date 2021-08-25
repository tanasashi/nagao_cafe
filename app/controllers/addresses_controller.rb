class AddressesController < ApplicationController

  def index
    @address = Address.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end


end
