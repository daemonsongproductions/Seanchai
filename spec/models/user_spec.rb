require 'spec_helper'

describe User do
  before(:each) do

  end

  def protected_attributes
    { :password => 'password',
      :password_salt => 'salt',
      :user_type_id  => '1'

    }
  end

  def correct_password
    "password"
  end

  it "should not allow password, password_salt or user_type to be set via mass assignment" do
    user = User.new(protected_attributes)
    user.password.should be nil
    user.password_salt.should be nil
    user.user_type.should be nil
  end

  it "should set the password_salt when the password is set" do
    user = User.new
    user.password = 'password'
    user.password_salt.should_not be nil
  end

  it 'should encrypt and salt the password' do
    user = User.new
    user.password = correct_password
    user.password.should_not match correct_password
    user.password.should_not match User.encrypt_password(correct_password, '')
    user.password.should match User.encrypt_password(correct_password, user.password_salt)
  end

  describe "Is Password Correct" do

    def incorrect_password
      "invalid"
    end

    def user_with_password
      user = User.new
      user.password = correct_password
      user
    end

    it "should return true if the supplied password matches the saved password" do
      user = user_with_password
      user.is_password?(correct_password).should be true
    end

    it "should return false if the supplied password does not match the saved password" do
      user = user_with_password
      user.is_password?(incorrect_password).should be false      
    end

    describe "Forgot My Password" do

      def existing_user
        user = User.new
        user.email = 'email@email.com'
        user.password = correct_password
        return user
      end

      it "should generate a new random password for the user." do
        user = existing_user
        User.stub(:save).and_return(true)

        new_password = user.create_new_password
        user.password.should match User.encrypt_password(new_password, user.password_salt)
        
      end

    end

  end

  describe "for_atleast" do

    before :each do
      @user = User.new
    end

    def mock_admin_user_type
        mock_model(UserType, :user_level => 2)
    end

    it "should return if no code block is passed" do

      @user.user_type  = mock_model(UserType)
      @user.user_type.should_not_receive(:user_level)
      @user.for_atleast(mock_admin_user_type)

    end

    it "should run the supplied code block if the user's role is at least that which was passed" do
      @user.user_type = mock_model(UserType, :user_level => 2)
      @user.for_atleast(mock_admin_user_type) {@authorized = true}
      @authorized.should be true
    end

    it "should not run the supplied code block if the user's role is less than that which was passed" do
      @user.user_type = mock_model(UserType, :user_level => 1)
      @user.for_atleast(mock_admin_user_type) {@authorized = true}
      @authorized.should_not be true
    end

  end

  describe "find" do

    it "should return a PseudoUser if an id of -1 is passed" do
      user = User.find(-1)
      user.class.should == PseudoUser
    end

  end


end
