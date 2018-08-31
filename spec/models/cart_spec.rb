require "rails_helper"

RSpec.describe Cart, :type => :model do
  context "Association" do
    it { should belong_to(:user) }
  end

  context "Validation" do
    
  end

end
