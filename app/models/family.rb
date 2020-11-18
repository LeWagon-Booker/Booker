class Family < ApplicationRecord
  has_one_attached :picture
  has_many :adhesions, dependent: :destroy
  has_many :users, through: :adhesions

  after_save :upload_default_picture

  def upload_default_picture
    file = File.open("#{Rails.root}/app/assets/images/defaultfamily.png")
    picture.attach(io: file, filename: 'picture.jpg', content_type: 'image/jpg') unless picture.attached?
  end
end
