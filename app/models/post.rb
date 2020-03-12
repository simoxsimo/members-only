class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 250 }

  belongs_to :user, foreign_key: 'user_id'
end
