class Recipe < ApplicationRecord
  has_many :favorite_marks

  validates :name, :instructions, :image_url, presence: true

  scope :only_favorite_by, ->(user) do
    joins(:favorite_marks).where(favorite_marks: {user_id: user.id})
  end

  def favorite_by_user?(user)
    self.favorite_marks.exists?(user: user)
  end

  def mark_as_favorite(user)
    self.favorite_marks.create(user: user) unless self.favorite_by_user?(user)
  end

  def unmark_as_favorite(user)
    self.favorite_marks.where(user: user).delete_all if self.favorite_by_user?(user)
  end
end