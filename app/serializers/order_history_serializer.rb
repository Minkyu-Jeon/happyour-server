class OrderHistorySerializer < ApplicationSerializer
  attributes :id, :evaluation, :eval_text, :url

  def url
    object.try(:url)
  end
end
