class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "1"
      Book.where("title LIKE?", "#{word}")
    elsif search == "2"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "3"
      Book.where("title LIKE?", "%#{word}")
    elsif search == "4"
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end

end
