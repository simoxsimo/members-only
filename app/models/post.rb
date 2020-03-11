class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :contnent, presence: true, length: { maximum: 250 }

  belongs_to :users, foreign_key: 'user_id'
end
