require "rails_helper"

RSpec.describe User, :type => :model do
  context "Association" do
    it { should have_one(:cart) }
    it { should have_many(:orders) }
    it { should have_many(:addresses) }
  end

  context "Validation" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
  end

  context "Functional" do
    let(:user) {create(:user, first_name: 'test', last_name: 'hi')}
    it 'get full name' do
      expect(user.full_name).to eq 'Test Hi'
    end
  end

end
