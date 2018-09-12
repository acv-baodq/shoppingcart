require "rails_helper"

RSpec.describe Address, :type => :model do
  let(:user) { create(:user) }
  let(:address) { create(:address, user_id: user.id) }
  context "Association" do
    it { should belong_to(:user) }
  end

  context "Validation" do
    it { should validate_presence_of(:line1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country_code) }
    it { should validate_presence_of(:state) }
  end

  context 'Functional' do
    it 'get located' do
      expect(address.located).to eq "#{address.line1}, Line2, City, State, Viet Nam"
    end
  end

end
