require 'rails_helper'

RSpec.describe Import::CreateBatch, :type => :interactor do
  
  let(:file) { build(:import_file) }
  let(:upload_file) { nil }
  let(:user) { create(:user) }
  subject(:context) { 
    Import::CreateBatch.call(
      :upload_file => upload_file,
      :created_by => user) 
  }

  context 'valid parameters' do
    let(:upload_file) { file.path }

    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:batch) { is_expected.to be_present }
    end

    describe Import::Batch do
      subject(:batch) { context.batch }

      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:created_by) { is_expected.to eq(user) }
    end
  end

  context 'passing uploaded file' do
    let(:upload_file) { ActionDispatch::Http::UploadedFile.new(
      :type => 'text/csv',
      :tempfile => file, :filename => File.basename(file),
      :head => "Content-Disposition: form-data; name=\"import_batch_input[upload_file]\"; filename=\"#{File.basename(file.path)}\"\r\nContent-Type: text/csv\r\n") }

    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
    end
  end

  context 'passing file path' do
    let(:upload_file) { file.path }

    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
    end
  end

  context 'invalid parameters' do
    # let(:file_path) { nil }
    let(:upload_file) { nil }

    describe 'context' do
      describe 'context' do
        its(:failure?) { is_expected.to be_truthy }
        its(:message) { is_expected.to match(/invalid/i) }
        its(:batch) { is_expected.to be_present }
      end
    end

    describe Import::Batch do
      subject(:batch) { context.batch }

      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end

end
