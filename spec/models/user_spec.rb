require 'spec_helper'

describe User do
  @attributes =  [
    'email',
    'first_name',
    'last_name',
    'nickname',
    'password',
    'password_confirmation',
    'password_digest',
    'registration_key',
    'password_reset_key',
    'registered_at'
  ]

  @attributes.each do |attribute|
    before(:each) do
      @user = User.new
    end

    it "should respond to #{attribute}" do
      @user.respond_to?("#{attribute}").should be_true
    end

    it "should respond to #{attribute}=" do
      @user.respond_to?("#{attribute}=").should be_true
    end
  end

  context "when created" do
    it "should create registration key" do
      user = FactoryGirl.create(:user)
      user.registration_key.blank?.should be_false
    end

    it "should create random registration key" do
      u1 = FactoryGirl.create(:user)
      u2 = FactoryGirl.create(:user)

      expect(u1.registration_key).not_to eq(u2.registration_key)
    end

    it "should send verification email"

    it "should have unique email" do
      FactoryGirl.create(:user, {email: "test@test.com"})
      user = FactoryGirl.build(:user, {email: "test@test.com"})
      user.save.should be_false
    end

    it "should have unique email by case" do
      FactoryGirl.create(:user, {email: "test@test.com"})
      user = FactoryGirl.build(:user, {email: "TEST@TEST.COM"})
      user.save.should be_false
    end

    @required_attributes = [
      'email',
      'first_name',
      'last_name',
      'nickname',
      'password_digest'
    ]

    @required_attributes.each do |attribute|
      it "should have a #{attribute}" do
        user = FactoryGirl.build(:user, {attribute => nil})
        user.save.should be_false
      end

      it "should not have empty #{attribute}" do
        user = FactoryGirl.build(:user, {attribute => ""})
        user.save.should be_false
      end
    end

    @invalid_emails = [
      'plainaddress',
      '#@%^%#$@#$@#.com',
      '@example.com',
      'Joe Smith <email@example.com>',
      'email.example.com',
      'email@example@example.com',
      'email@example.com (Joe Smith)',
      'email@example',
      'email@111.222.333.44444',
      'email@example..com',
    ]

    @invalid_emails.each do |email|
      it "should not accept #{email} as valid" do
        user = FactoryGirl.build(:user, {email: email})
        user.save.should be_false
      end
    end
  end
end
