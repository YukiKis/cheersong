require "rails_helper"

RSpec.describe Room, type: :model do
  context "on validation" do
    it "has many messages" do
      expect(Room.reflect_on_association(:messages).macro).to eq :has_many
    end
  end
end