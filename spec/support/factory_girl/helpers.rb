module Smuggler
  module FactoryGirlHelpers
    # Creates a new import file.
    #
    # @param  definition [Array] an array of purchase order lines to create
    def create_import_file(lines)
      file = Tempfile.new(['purchase_orders', '.csv'])

      CSV.open(file, "w") do |csv|
        lines.each do |line|
          csv << line.map { |x| x.to_s }
        end
      end

      file
    end

    # Creates an array of new import lines.
    #
    # @param  array_of_po_hash [Array] purchase orders to create
    def create_import_file_lines(array_of_po_hash)
      fields = [
          'Sender',
          'Receiver', 
          'PO Number', 
          'PO Date',
          'Ship-To Location',
          'Line Nbr',
          'Quantity',
          'Unit Price',
          'UOM  Basis of UOM',
          'Buyer Item Nbr',
          'dtl_user_defined_field3',
          'Delivery Date Requested',
          'Last Delivery Date Requested'
        ]
      lines = []
      lines << fields

      array_of_po_hash.each do |po_hash|
        sender = po_hash[:sender] || Faker::Number.number(12)
        receiver = po_hash[:receiver] || Faker::Number.number(12)
        po_number = po_hash[:number] || Faker::Number.number(10)
        po_date = po_hash[:date] || Time.now.to_date
        ship_to_location =
          po_hash[:ship_to_location] || Faker::Number.number(11)

        (1..po_hash[:lines].length).each do |i|
          po_line = po_hash[:lines][i - 1]
          quantity = po_line[:quantity] || 10
          unit_price = po_line[:unit_price] || 100
          item_number = po_line[:buyer_item_number] || Faker::Number.number(9)
          uom = po_line[:uom_basis_of_uom] || 'EA'
          dtl_user_defined_field3 = 1

          lines << [
            sender,
            receiver,
            po_number,
            po_date,
            ship_to_location,
            i,
            quantity,
            unit_price,
            uom,
            item_number,
            dtl_user_defined_field3,
            Time.now.to_date,
            Time.now.to_date + 1.day
          ]
        end
      end
      lines
    end
  end
end
