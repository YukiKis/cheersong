require "rails_helper"

RSpec.describe User, type: :mdoel do
  let(:user1){ create(:user1) }
  context "on validation" do
    it "has many passive_relationships" do
      expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
    end
    it "has many active_relationships" do
      expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
    end
    it "is valid" do
      expect(user1).to be_valid
    end
  end
  context "on method" do
  end
end