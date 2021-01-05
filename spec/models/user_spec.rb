require "rails_helper"

RSpec.describe User, type: :mdoel do
  let(:user1){ create(:user1) }
  let(:user2){ create(:user2) }
  context "on validation" do
    it "has many keys" do
      expect(User.reflect_on_association(:keys).macro).to eq :has_many
    end
    it "has many messages" do
      expect(User.reflect_on_association(:messages).macro).to eq :has_many
    end
    it "has many rooms through keys" do
      expect(User.reflect_on_association(:room).macro).to eq :has_many
    end
    it "has many passive_relationships" do
      expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
    end
    it "has many active_relationships" do
      expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
    end
    it "has many followers" do
      expect(User.reflect_on_association(:followers).macro).to eq :has_many
    end
    it "has many followings" do
      expect(User.reflect_on_association(:followings).macro).to eq :has_many
    end
    it "is valid" do
      expect(user1).to be_valid
    end
    it "is invalid without name" do
      user1.name = ""
      expect(user1).to be_invalid
    end
  end
  context "on method" do
    it "checks whether following now or not" do
      user1.follow(user2)
      expect(user1.following?(user2)).to be_truthy
    end
    it "follows user" do
      expect{ user1.follow(user2) }.to change{ user1.active_relationships.count }.by(1)
    end
    it "unfollows user" do
      user1.follow(user2)
      expect{ user1.unfollow(user2) }.to change{ user1.active_relationships.count }.by(-1)
    end
  end
end