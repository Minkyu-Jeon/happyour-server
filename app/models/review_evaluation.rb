class ReviewEvaluation < ApplicationRecord
	EVALUATIONS = [0,1] # 싫어요, 좋아요
	belongs_to :user, inverse_of: :review_evaluations
	belongs_to :review, inverse_of: :review_evaluations

	validates :user, :review, presence: true, on: :create
	validates :evaluation, inclusion: { in: EVALUATIONS }
end
