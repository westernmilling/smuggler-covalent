class EntityDecorator < Draper::Decorator
  delegate_all

  # def long_name


  # TODO: Replace this with long_name and the models cached_full_name
  # with cached_long_name
  # TODO: Build the address portion from the Location (address_lines)
  def full_name
    "#{reference} - \
#{display_name}, \
#{street_address}, \
#{city}, \
#{region}, \
#{region_code}, \
#{country}"
  end

end
