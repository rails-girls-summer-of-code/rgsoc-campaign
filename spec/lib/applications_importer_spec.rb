require 'spec_helper'
require 'applications/importer'

describe Applications::Importer do
  let(:data) { "Timestamp,Student Name,Student E-mail Address,how much money\n1,2,3\n4,5,6" }
  subject { importer(data) }

  def importer(data)
    Applications::Importer.new(Application, data)
  end

  before :each do
    Application.delete_all # ...
  end

  it 'imports applications' do
    expect { subject.run }.to change(Application, :count).by(2)
  end

  describe 'when updating an existing application' do
    before do
      subject.run
    end

    it 'does not add a new record' do
      expect { subject.run }.not_to change(Application, :count)
    end

    it 'actually updates the record' do
      importer(data.gsub('2', '8')).run
      expect(Application.first.data['Student Name']).to eq('8')
    end
  end
end


