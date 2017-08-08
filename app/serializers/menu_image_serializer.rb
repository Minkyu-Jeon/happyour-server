class MenuImageSerializer < ApplicationSerializer
  attributes :id, :url

  belongs_to :menu

  def menu
    object.try(:menu)
  end

  def url
    object.url.try(:url)
  end
end
