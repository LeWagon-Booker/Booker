class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :book_ownerships
  has_many :wishlists, dependent: :destroy
  has_many :books, through: :book_ownerships
  has_many :adhesions, dependent: :destroy
  has_many :families, through: :adhesions
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  after_save :upload_default_avatar
  has_many :familyadmin

  def full_name
    "#{first_name} #{last_name}"
  end

  def upload_default_avatar
    file = File.open("#{Rails.root}/app/assets/images/defaultavatar.jpg")
    avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg') unless avatar.attached?
  end
end
