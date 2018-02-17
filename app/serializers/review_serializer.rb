class ReviewSerializer < ApplicationSerializer
  attributes :id, :eval_text, :evaluations

  belongs_to :user

  def evaluations
  	result = Hash.new(0)
  	evaluation = { "0" => :poor, "1" => :good }
  	object.review_evaluations.each { |e| result[evaluation[e.evaluation.to_s]] += 1 }
  	result
  end
end
