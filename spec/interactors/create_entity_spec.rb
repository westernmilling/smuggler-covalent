require 'rails_helper'

RSpec.describe CreateEntity, :type => :interactor do

  let(:name) { Faker::Company.name }
  let(:reference) { Faker::Number.number(8) }
  let(:street_address) { Faker::Address.street_address }
  let(:city) { Faker::Address.city }
  let(:region) { Faker::Address.state }
  let(:region_code) { Faker::Address.zip_code }
  let(:country) { 'United States' }
  let(:roles) { %w'customer' }
  let(:source) { nil }
  let(:uuid) { nil }
  subject(:context) { 
    CreateEntity.call(
      :country => country,
      :city => city,
      :name => name, 
      :reference => reference, 
      :region => region,
      :region_code => region_code,
      :street_address => street_address,
      :roles => roles,
      :uuid => uuid) 
  }

  context 'valid parameters' do
    describe 'context' do
      it 'is successful' do
        expect(context).to be_a_success
      end

      it 'message contains success' do
        expect(context.message).to match(/success/i)
      end

      it 'has set the entity' do
        expect(context.entity).to be_present
      end
    end

    describe Entity do
      subject(:entity) { context.entity }

      it 'has been persisted' do
        expect(entity).to be_persisted
      end

      it 'display_name is defaulted to name' do
        expect(entity.display_name).to eq(name)
      end

      it 'cached_full_name is present' do
        expect(entity.cached_full_name).to be_present
      end

      it 'source is local' do
        expect(entity.source).to eq(:local)
      end
    end
  end

  context 'invalid parameters' do
    let(:name) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the entity' do
        expect(context.entity).to be_present
      end
    end

    describe Entity do
      subject(:entity) { context.entity }

      it 'has not been persisted' do
        expect(entity).not_to be_persisted
      end
    end
  end

end
