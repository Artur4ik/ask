class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  validates(:body, presence: true)
  validates(:user_id, presence: true)
end
