require 'rails_helper'

RSpec.describe BuyerDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user)
    @buyer_destination = FactoryBot.build(:buyer_destination, user_id: user.id, item_id: item.id)
  end

  describe '商品購入情報の保存' do
    context '商品購入情報の保存ができる場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@buyer_destination).to be_valid
      end

      it '建物名は空でも保存できること' do
        @buyer_destination.building = ''
        expect(@buyer_destination).to be_valid
      end
    end

    context '商品購入情報の保存ができない場合' do
      it "tokenが空では登録できないこと" do
        @buyer_destination.token = nil
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Token can't be blank")
      end
      
      it '郵便番号が空だと保存できないこと' do
        @buyer_destination.postal_code = ''
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号がハイフン無しでは保存できないこと' do
        @buyer_destination.postal_code = '1234567'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '郵便番号が全角では保存できないこと' do
        @buyer_destination.postal_code = '１２３－４５６７'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '都道府県が空だと保存できないこと' do
        @buyer_destination.prefecture_id = nil
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
         
      it '市区町村が空だと保存できないこと' do
          @buyer_destination.city = ''
          @buyer_destination.valid?
          expect(@buyer_destination.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @buyer_destination.address = ''
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @buyer_destination.phone_number = ''
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では保存できないこと' do
        @buyer_destination.phone_number = '123456789'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Phone number is too short")
      end

      it '電話番号が12桁以上では保存できないこと' do
        @buyer_destination.phone_number = '123456789012'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Phone number is invalid. Input only number", "Phone number is too short")
      end

      it '電話番号にハイフンが含まれていると保存できないこと' do
        @buyer_destination.phone_number = '090-1234-5678'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it '電話番号は全角では保存できない' do
        @buyer_destination.phone_number = '０９０１２３４５６７８'
        @buyer_destination.valid?
        expect(@buyer_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
    end
  end
end
