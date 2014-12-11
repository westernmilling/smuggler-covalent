require 'csv'

class PurchaseOrder::CsvBuilder
  attr_reader :csv_lines
  attr_reader :fields
  attr_reader :purchase_orders

  def initialize
    @csv_lines = []
    @purchase_orders = []
    @fields = PurchaseOrder::DenormalizedLine.
      properties.
      collect { |k, v| k }
  end

  def add(po)
    if @csv_lines.empty?
      @csv_lines << @fields.join(',')
    end
    @purchase_orders << po

    lines = PurchaseOrder::DenormalizedLine.create_instances(po)
    lines.each do |line|
      @csv_lines
      row = CSV::Row.new([],[],false)
      @fields.each do |key|
        row << line[key]
      end
      # Chomp the \n from the end of the string
      @csv_lines << row.to_csv.chomp 
    end

    self
  end

end