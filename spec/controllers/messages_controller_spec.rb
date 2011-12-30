require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MessagesController do
  let!(:game) {Factory.create(:game)}
  let!(:chatroom) {Factory.create(:chatroom, :game => game)}
  let!(:user) {Factory.create(:user)}
  let!(:malicious){Factory.create :user}
  let!(:power) {game.powers.first}
  let!(:message) {Factory.create(:message, :power => power, :chatroom => chatroom, :text => 'Hello there!')}
  let(:valid_attributes) {{:power => power, :text => 'some text'}}

  before {
    game.assign_user(user, power)
    chatroom.powers << game.powers.first
    chatroom.save
  }

  shared_examples "MessagesController action" do
    it "should return 401 Unauthorized if the user is non the given chatroom" do
      controller.should_receive(:logged_user).and_return(malicious)
      get :index, :chatroom_id => chatroom.id
      response.status.should == 401
    end

    it "should return 404 without chatroom_id" do
      expect{get :index}.to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET index" do
    it_behaves_like "MessagesController action"

    it "assigns all messages as @messages" do
      get :index, :chatroom_id => chatroom.id
      assigns(:messages).should eq([message])
    end
  end

  describe "POST create", :focus => true do
    it_behaves_like "MessagesController action"
    subject{post :create, :chatroom_id => chatroom.id, :message => {:text => 'new message'}, :format => 'js'}
    it "creates a new Message" do
      expect{subject}.to change{Message.count}.by(1)
    end

    it "assigns a newly created message as @message" do
      subject
      assigns(:message).should be_a(Message)
      assigns(:message).should be_persisted
    end
  end
end
