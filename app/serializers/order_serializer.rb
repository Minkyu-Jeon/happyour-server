class OrderSerializer < ApplicationSerializer
  attributes :is_receive

  belongs_to :menu

  def menu
    object.try(:menu)
  end
end
