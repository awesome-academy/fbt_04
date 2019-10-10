# spec/views/users/edit.rb
require "rails_helper"

RSpec.describe "users/edit.html.erb", type: :view do
  let(:user_factory) {FactoryGirl.create :user}

  context "when first access" do
    before do
      assign(:user, User.new)
      render
    end

    it "return a 6 field" do
      expect(rendered).to have_field("user[fullname]")
      expect(rendered).to have_field("user[email]")
      expect(rendered).to have_field("user[phone]")
      expect(rendered).to have_field("user[address]")
      expect(rendered).to have_field("user[password]")
      expect(rendered).to have_field("user[password_confirmation]")
    end
  end

  context "when update fail" do
    before do
      user_factory[:fullname] = ""
      user_factory.save
      assign(:user, user_factory)
      render
    end

    it "return value" do
      expect(rendered).to have_field("user[fullname]", with: "#{user_factory.fullname}")
      expect(rendered).to have_field("user[email]", with: "#{user_factory.email}")
    end

    it "return message" do
      expect(rendered).to have_content("Fullname can't be blank")
    end
  end
end
