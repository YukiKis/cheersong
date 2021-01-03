require "rails_helper" 

RSpec.describe "User-devise page", type: :system do
  context "on register-new" do
    before do
      visit new_user_registration_path
    end
    it "has form for name" do
      expect(page).to have_field "user[name]"
    end
    it "has form for email" do
      expect(page).to have_field "user[email]"
    end
    it "has form for password" do
      expect(page).to have_field "user[password]"
    end
    it "has form for password_confirmation" do
      expect(page).to have_field "user[password_confirmation]"
    end
    it "has button to submit" do
      expect(page).to have_button "登録"
    end
    it "succeeds to register" do
      fill_in "user[name]", with: "yuki"
      fill_in "user[email]", with: "yuki@com"
      fill_in "user[password]", with: "testtest"
      fill_in "user[password_confirmation]", with: "testtest"
      expect{ click_button "登録" }.to change{ User.all.count }.by(1)
      expect(page).to have_content "successfully"
    end
    it "fails to register" do
      click_button "登録"
      expect(page).to have_content "エラー"
    end
  end
  context "on new-session" do
    let(:user1){ create(:user1) }
    before do
      visit new_user_session_path
    end
    it "has form for name" do
      expect(page).to have_field "user[name]"
    end
    it "has form for password" do
      expect(page).to have_field "user[password]"
    end
    it "has button to submit" do
      expect(page).to have_button "ログイン"
    end
    it "succeeds to login" do
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "ログイン"
      expect(page).to have_content "successfully"
    end
    it "fails to login" do
      click_button "ログイン"
      expect(page).to have_content "エラー"
    end
  end
end