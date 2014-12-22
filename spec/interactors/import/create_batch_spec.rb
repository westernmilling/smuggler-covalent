require 'rails_helper'

RSpec.describe Import::CreateBatch, :type => :interactor do
  let(:file) { create_import_file(import_lines) }
  let(:upload_file) { nil }
  let(:import_data) do
    [ { :lines => [{}, {}, {}] } ]
  end
  let(:import_lines) { create_import_file_lines(import_data) }
  let(:user) { create(:user) }
  subject(:context) do
    with_versioning do
      Import::CreateBatch.call(
        :upload_file => upload_file,
        :user => user)
    end
  end

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

      describe 'papertrail' do
        it 'has 1 version' do
          expect(batch.versions.size).to eq(1)
        end

        it 'was created by user' do
          expect(batch.originator.to_i).to eq(user.id)
        end
      end
    end
  end

  context 'passing uploaded file' do
    let(:upload_file) do
      ActionDispatch::Http::UploadedFile.new(
        :type => 'text/csv',
        :tempfile => file,
        :filename => File.basename(file),
        :head => [
          'Content-Disposition: form-data',
          'name="import_batch_input[upload_file]"',
          "filename=\"#{File.basename(file.path)}\"",
          'Content-Type: text/csv\r\n'].join(';'))
    end

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
    let(:upload_file) { nil }

    describe 'context' do
      its(:failure?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/invalid/i) }
      its(:batch) { is_expected.to be_present }
    end

    describe Import::Batch do
      subject(:batch) { context.batch }

      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end
end
