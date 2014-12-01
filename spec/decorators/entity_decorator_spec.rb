require 'rails_helper'

RSpec.describe EntityDecorator, :type => :decorator do
  let(:entity) { build(:entity) }
  subject { entity.decorate }

  its(:full_name) { should eq("#{entity.reference} - \
#{entity.display_name}, \
#{entity.street_address}, \
#{entity.city}, #{entity.region}, #{entity.region_code}, #{entity.country}") } 

end
