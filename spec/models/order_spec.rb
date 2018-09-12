require "rails_helper"

RSpec.describe Order, :type => :model do
  context "Association" do
    it { should belong_to(:user) }
  end

  context "Validation" do
  end
end
