require "rails_helper"

RSpec.describe Message, type: :model do
  let(:user1){ create(:user1) }
  let(:room){ create(:room) }
  let(:message){ build(:message, user: user1, room: room) }
  context "on validation" do
    it "belongs_to user" do
      expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to room" do
      expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(message).to be_valid
    end
    it "is invalid without content" do
      message.content = ""
      expect(message).to be_invalid
    end
  end
end