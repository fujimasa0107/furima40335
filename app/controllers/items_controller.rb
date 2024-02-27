class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def show
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else      
      Rails.logger.info @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else      
      Rails.logger.info @item.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
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

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user_id && @item.buyer.nil?
  end
end
