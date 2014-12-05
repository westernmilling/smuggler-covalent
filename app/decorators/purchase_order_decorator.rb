class PurchaseOrderDecorator < Draper::Decorator
  delegate_all

  def ship_to_entity_display_string
    if ship_to_entity
      ship_to_entity.decorate.display_string
    end
  end

end
