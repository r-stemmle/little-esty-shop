class Merchants::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to merchant_item_path(merchant, item)
      flash[:success] = 'Item successfully updated!'
    else
      redirect_to edit_merchant_item_path(merchant, item)
      flash[:error] = "Error: #{error_message(item.errors)}"
    end
  end

  def toggle_enabled
    @item = Item.find(params[:id])
    @item.toggle!(:enabled)
    redirect_to merchant_items_path
  end

  def new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)

    if item.save
      redirect_to merchant_items_path
    else
      redirect_to new_merchant_item_path
      flash[:error] = "Error: #{error_message(item.errors)}"
    end

  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
