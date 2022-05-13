class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates(:body, presence: true)
  validates(:user_id, presence: true)
  self.per_page = 4
end
