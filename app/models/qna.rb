class Qna < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  validates :title, :body, presence: true
end
