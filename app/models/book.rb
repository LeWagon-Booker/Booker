class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :category
  has_many :book_ownerships, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :book_ownerships
  after_save :upload_default_cover

  include PgSearch::Model
  multisearchable against: %i[title description author users]

  private

  def upload_default_cover
    file = File.open("#{Rails.root}/app/assets/images/defaultcover.jpg")
    cover.attach(io: file, filename: 'cover.jpg', content_type: 'image/jpg') unless cover.attached?
  end
end
