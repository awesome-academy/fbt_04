# spec/models/user.rb
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  subject {user}

  #test validate
  context ".validate :" do
    before {user.save}
    it "has a valid factory" do
      expect(user).to be_valid
    end

    #validate for fullname attributes

    context "when fullname empty" do
      before {user.fullname = ""}
      it {expect(user).to_not be_valid}
    end

    context "when length is 50 or less" do
      it {expect(user.fullname.length).to be <= 50}
    end

    context "when length is more than 50" do
      before {user.fullname = "a"*200}
      it {expect(user.fullname.length).to_not be <= 50}
    end

    it "is not invalid when without a email" do
      user.email = ""
      expect(user).to_not be_valid
    end

    it "is not invalid when not exaclly a email" do
      user.email = "abc$sun-asterisk,com"
      expect(user).to_not be_valid
    end

    it "when email is unique" do
      duplicate_user = user.dup
      duplicate_user.email = user.email
      duplicate_user.save
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it "is not invalid without a password" do
      FactoryGirl.build(:user, password: nil).should_not be_valid
    end
  end

  context ".associations :" do
    it "has many booking_tours" do
      assc = User.reflect_on_association :booking_tours
      expect(assc.macro).to eq :has_many
    end

    it "has many rating_tours" do
      assc = User.reflect_on_association :rating_tours
      expect(assc.macro).to eq :has_many
    end

    it "has many comments" do
      assc = User.reflect_on_association :comments
      expect(assc.macro).to eq :has_many
    end

    it "has many imagerelations" do
      assc = User.reflect_on_association :imagerelations
      expect(assc.macro).to eq :has_many
    end

    it "has many reactions" do
      assc = User.reflect_on_association :reactions
      expect(assc.macro).to eq :has_many
    end

    it "has many reviews" do
      assc = User.reflect_on_association :reviews
      expect(assc.macro).to eq :has_many
    end
  end

  context ".when search user by name" do
    before do
      @tan = FactoryGirl.create(:user, fullname: "Tran Ngoc Tan")
      @tuyen = FactoryGirl.create(:user, fullname: "Tran Thi Ngoc Tuyen")
      @thuy = FactoryGirl.create(:user, fullname: "Dang Thi Thuy")
      @trai = FactoryGirl.create(:user, fullname: "Tran Ngoc Trai")
    end
    it "return true maching name" do
      User.by_name("tran").should == [@tan, @tuyen, @trai]
    end

    it "return false non-maching name" do
      User.by_name("tran").should_not include @thuy
    end
  end

  describe "#downcase_email" do
    before do
      user.email = "TranNgocTan@gmail.com"
      user.save
    end
    it "return email downcase before save to database" do
      expect(user.email).to eq "tranngoctan@gmail.com"
    end
  end

  describe "#careate activation digest" do
    context "when create user" do
      it "return activation token" do
        expect(user.activation_token.class).to be(String)
      end

      it "return active digest" do
        expect(user.active_digest.class).to be(String)
      end
    end
  end

  describe "#forget" do
    context "when logout user call forget to" do
      before do
        user.forget
      end
      it "return nil for remember_digest" do
        expect(user.remember_digest).to be(nil)
      end
    end
  end

  describe "#remember" do
    context "when remember invoked" do
      before do
        user.remember
      end

      it "return a new remember token" do
        expect(user.remember_token.class).to be(String)
      end

      it "return remember_digest is present" do
        expect(user.remember_digest.class).to be(String)
      end
    end
  end
end
