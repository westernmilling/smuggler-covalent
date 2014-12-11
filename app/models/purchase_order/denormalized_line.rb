class PurchaseOrder::DenormalizedLine < Hashie::Dash
  property :earliest_request_date
  property :latest_request_date
  property :purchase_order_date
  property :purchase_order_number
  property :ship_to_reference
  property :product_reference
  property :quantity
  property :line_number
  property :unit_price

  class << self
    def create_instances(po)
      instances = []
      po.lines.each do |line|
        instances << PurchaseOrder::DenormalizedLine.new({
          :purchase_order_date => po.date,
          :purchase_order_number => po.number,
          :ship_to_reference => po.ship_to_entity.reference,
          :earliest_request_date => po.earliest_request_date,
          :latest_request_date => po.latest_request_date,
          :line_number => line.line_number,
          :product_reference => line.product.reference,
          :quantity => line.quantity,
          :unit_price => line.unit_price
        })
      end

      instances
    end

    def property_symbols
      PurchaseOrder::DenormalizedLine.
        properties.
        collect { |k, v| k }
    end
  end
end