# Entity class representing some kind of business entity
#
# An instance of an Entity class may be a customer, vendor, trucking company, 
# all of the above, or something else.
#
# TODO: Move the Entity class and related functionality 
# (i.e. CreateEntity interactor) to its own gem.
# 
class Entity < ActiveRecord::Base
  symbolize :source

  validates_presence_of :cached_full_name
  validates_presence_of :city
  validates_presence_of :country
  validates_presence_of :display_name
  validates_presence_of :name
  validates_presence_of :reference
  validates_presence_of :region
  validates_presence_of :region_code
  validates_presence_of :roles
  validates_presence_of :source
  validates_presence_of :street_address
  validates_presence_of :uuid

end
