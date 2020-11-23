class Book < ApplicationRecord
  has_one_attached :cover
  belongs_to :category
  has_many :wishlists, dependent: :destroy
  has_many :book_ownerships, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :book_ownerships
  after_save :upload_default_cover
  validates :ISBN, uniqueness: true, :allow_blank => true
  validates :title, presence: true
  validates :author, presence: true

  $categories = Category.select('distinct name').collect { |p| p.name }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [[:title, 'A'], :description, [:author, 'B'], :year, :ISBN],
    associated_against: {
      category: :name,
      users: [:first_name, :last_name, :email, :username]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def upload_default_cover
    file = File.open("#{Rails.root}/app/assets/images/defaultcover.jpg")
    cover.attach(io: file, filename: 'cover.jpg', content_type: 'image/jpg') unless cover.attached?
  end
end
