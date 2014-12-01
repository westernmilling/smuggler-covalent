require 'csv'

def create_file_data
  header = [
    'Sender',
    'Receiver', 
    'PO Number', 
    'PO Date',
    'Ship-To Location',
    'Line Nbr',
    'Quantity',
    'Unit Price',
    '\"UOM  Basis of UOM\"',
    'Buyer Item Nbr',
    'Delivery Date Requested',
    'Last Delivery Date Requested'
  ]

  sender = Faker::Number.number(12)
  receiver = Faker::Number.number(12)
  po_number = Faker::Number.number(10)
  po_date = Time.now.to_date
  ship_to_location = Faker::Number.number(11)
  quantity = 10
  unit_price = 100
  item_number = Faker::Number.number(9)

  lines = []
  lines << header

  (1..3).each do |i|
    lines << [
      sender,
      receiver,
      po_number,
      po_date,
      ship_to_location,
      i,
      quantity,
      unit_price,
      'EA',
      item_number,
      Time.now.to_date,
      Time.now.to_date# + 1.month
    ]
  end

  lines

  # lines += [
  #     sender,
  #     receiver,
  #     po_number,
  #     po_date,
  #     ship_to_location,
  #     i,
  #     quantity,
  #     unit_price,
  #     'EA',
  #     item_number,
  #     Time.now.to_date,
  #     Time.now.to_date# + 1.month
  #   ] * 3



  # header = [
  #   'Sender',
  #   'Receiver', 
  #   'PO Number', 
  #   'Release Number',
  #   'PO Date',
  #   'Terms Info',
  #   'FOB Info',
  #   'Ship-To Name',
  #   'Ship-To Address 1',
  #   'Ship-To Address 2',
  #   'Ship-To Location',
  #   'Ship-To City',
  #   'Ship-To State',
  #   'Ship-To Postal Code',
  #   'Ship-To Country',
  #   'Ship-To Contact',
  #   'Bill-To Name',
  #   'Bill-To Address 1',
  #   'Bill-To Address 2',
  #   'Bill-To Location',
  #   'Bill-To City',
  #   'Bill-To State',
  #   'Bill-To PostalCode',
  #   'Bill-To Country',
  #   'Bill-To Contact',
  #   'hdr_user_defined_field1',
  #   'hdr_user_defined_field2',
  #   'hdr_user_defined_field3',
  #   'hdr_user_defined_field4',
  #   'hdr_user_defined_field5',
  #   'hdr_user_defined_field6',
  #   'hdr_user_defined_field7',
  #   'hdr_user_defined_field8',
  #   'hdr_user_defined_field9',
  #   'hdr_user_defined_field10',
  #   'hdr_user_defined_field11',
  #   'hdr_user_defined_field12',
  #   'hdr_user_defined_field13',
  #   'hdr_user_defined_field14',
  #   'hdr_user_defined_field15',
  #   'hdr_user_defined_field16',
  #   'hdr_user_defined_field17',
  #   'hdr_user_defined_field18',
  #   'hdr_user_defined_field19',
  #   'hdr_user_defined_field20',
  #   'Notes',
  #   'Line Nbr',
  #   'Supplier Item Nbr',
  #   'Item Description',
  #   'Quantity',
  #   'Unit Price',
  #   '"UOM  Basis of UOM"',
  #   'Buyer Item Nbr',
  #   'Manufacturer Item Nbr',
  #   'dtl_user_defined_field1',
  #   'dtl_user_defined_field2',
  #   'dtl_user_defined_field3',
  #   'dtl_user_defined_field4',
  #   'dtl_user_defined_field5',
  #   'dtl_user_defined_field6',
  #   'dtl_user_defined_field7',
  #   'dtl_user_defined_field8',
  #   'dtl_user_defined_field9',
  #   'dtl_user_defined_field10',
  #   'dtl_user_defined_field11',
  #   'dtl_user_defined_field12',
  #   'dtl_user_defined_field13',
  #   'dtl_user_defined_field14',
  #   'dtl_user_defined_field15',
  #   'dtl_user_defined_field16',
  #   'dtl_user_defined_field17',
  #   'dtl_user_defined_field18',
  #   'dtl_user_defined_field19',
  #   'dtl_user_defined_field20',
  #   'PO Purpose',
  #   'SAC Info',
  #   'Delivery Date Requested',
  #   'Last Delivery Date Requested',
  #   'Sub-Line Item',
  #   'Item Info'
  # ]
end 


FactoryGirl.define do
  factory :import_file, :class => Tempfile do  
    to_create {}  

    initialize_with do
      file = Tempfile.new(['purchase_orders', '.csv'])
      lines = create_file_data

      # puts "Lines: #{lines.to_yaml}"

      CSV.open(file, "w") do |csv|        
        lines.each do |line|
          csv << line.map { |x| x.to_s }
        end
      end

      file
    end


  end
end