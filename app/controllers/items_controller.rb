class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index,:new]
  #before_action :authenticate_user!
  def index
    
  end

  def new
    @item = Item.new
  end


  private

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def item_params
    params.require(:item).permit(
      :name, 
      :price, 
      :description, 
      :category_id, 
      :condition_id, 
      :shipping_cost_id, 
      :prefecture_id, 
      :shipping_date_id, 
      :image
    ).merge(user_id: current_user.id)
  end
end
