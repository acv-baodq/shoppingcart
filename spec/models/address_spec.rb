require "rails_helper"

RSpec.describe Address, :type => :model do
  context "Association" do
    it { should belong_to(:user) }
  end

  context "Validation" do
    it { should validate_presence_of(:line1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country_code) }
    it { should validate_presence_of(:state) }
  end

end
