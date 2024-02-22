class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items 
  has_many :buyers

  #出来ていたら消すvalidates :email, presence: true, uniqueness: true
  #validates :encrypted_password, presence: true
  validates :nickname, presence: true

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々]+\z/
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }

  # ユーザー本名のフリガナ（全角カタカナ）のバリデーション
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  
  validates :birth_date, presence: true

  #パスワードに英数字に混合が必要なバリデーション
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
  },on: :create

end
