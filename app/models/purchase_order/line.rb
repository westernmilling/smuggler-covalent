# PurchaseOrder
class PurchaseOrder
  # Represents a line on a +PurchaseOrder+
  class Line < ActiveRecord::Base
    belongs_to :product
    belongs_to :purchase_order
    belongs_to :unit_of_measure

    has_paper_trail

    validates \
      :line_number,
      :product,
      :purchase_order,
      :quantity,
      :unit_of_measure,
      :unit_price,
      :presence => true
  end
end
