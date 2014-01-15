require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
    @user.old_password = @user.password
  end
  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:old_password) }

  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { @user.username = "a" * 5 }
    it { should_not be_valid }
  end

  describe "when username is not valid" do
    it "should not be valid" do
      usernames = %w[abc%abc dragon\ asdf abc-adc134]

      usernames.each do |invalid_username|
        @user.username = invalid_username
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when username is valid" do
    it "should be valid" do
      usernames = %w[abcabc abc123 abc_abc123]

      usernames.each do |username|
        @user.username = username
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is not valid" do
    it "should not be valid" do
      emails = %w[abc+%^&asd@abc.com adf adf abc asdf%$abc@sdf.com.vn.vn]

      emails.each do |invalid_email|
        @user.email = invalid_email
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      emails = %w[abcasd@abc.com adfgh@adf.vn asdf.abc@sdf.com]

      emails.each do |valid_email|
        @user.email = valid_email
        expect(@user).to be_valid
      end
    end
  end

  describe "when saving user, email should be downcased" do
    let(:downcased_email) { @user.email.downcase }
    before do
      @user.email = @user.email.upcase
      @user.save
    end

    specify { expect(@user.reload.email).to eq downcased_email }
  end

  describe "when password is too short" do
    before do
      @user.password = "a" * 5
      @user.password_confirmation = "a" * 5
    end

    it { should_not be_valid }
  end

  describe "when username is already taken" do
    let(:user_with_same_username) { @user.dup }
    subject { user_with_same_username }

    before do
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when email is already taken" do
    let(:user_with_same_email) { @user.dup }
    subject { user_with_same_email }

    before do
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(username: "SuperLinh", email: "superlinh@super.com",
                      password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(username: @user.username) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let (:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
