class Qna < ApplicationRecord
  belongs_to :user, inverse_of: :qnas
  belongs_to :admin
  validates :title, :body, presence: true
end
