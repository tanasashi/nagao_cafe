class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:name, :image_id, :introduction, :price, :is_active, :genre_id)
  end


end
