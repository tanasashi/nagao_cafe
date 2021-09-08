class Admin::AdminController < ApplicationController

  def top
    @orders = Order.all
  end

end
