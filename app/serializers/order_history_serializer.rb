class OrderHistorySerializer < ApplicationSerializer
  attributes :id, :evaluation, :eval_text, :url

  def url
    object.url.try(:filename)
  end
end
