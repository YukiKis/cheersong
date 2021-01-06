require "rails_helper"

RSpec.describe "room-page", type: :system do
  let(:user1){ create(:user1) }
  let(:user2){ create(:user2) }
  before do
    login_user user1
  end
  context "on index" do
    before do
      visit user_rooms_path
    end
  end
  
  context "on show" do
    before do
      @room = Room.create
      @room.users << [user1, user2]
      visit user_room_path(user1)
    end
    it "has name of other" do
      expect(page).to have_content user2.name
    end
    it "has content of messages" do
      @room.messages.all.each do |message|
        expect(page).to have_content message.user.name
        expect(page).to have_content message.content
        expect(page).to have_content message.created_at.strftime("%Y%m%d %H%M%H")
      end
    end
    it "has back link to show" do
      expect(page).to have_link "Back", user_path(user2)
    end
  end
end