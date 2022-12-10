class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships,source: :followed
  has_many :followers, through: :reverse_of_relationships,source: :follower

  validates :name, length: {minimum: 2,maximum: 20},uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def following?(user)
    followings.include?(user)
  end

  def self.looks(search,word)
    if search == "1"
      User.where("name LIKE?", "#{word}")
    elsif search == "2"
      User.where("name LIKE?", "#{word}%")
    elsif search == "3"
      User.where("name LIKE?", "%#{word}")
    elsif search == "4"
      User.where("name LIKE?", "%#{word}%")
    else
      User.all
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
