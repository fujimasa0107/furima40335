class BuyersController < ApplicationController

  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, except: [:index, :create]


  def index
    @buyer_destination = BuyerDestination.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_destination = BuyerDestination.new(buyer_params)
    if @buyer_destination.valid?
      pay_item
      @buyer_destination.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_destination).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
                   user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,           # 商品の値段
      card: buyer_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_seller
    if current_user == @item.user
      redirect_to root_path
    end
  end


  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
