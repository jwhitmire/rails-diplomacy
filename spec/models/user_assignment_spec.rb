require 'spec_helper'

describe UserAssignment do
  let(:game) {Factory.create :game}
  let(:user) {Factory.create :user}

  it "should not have two instances for the same user game combination" do
    expect{UserAssignment.create(:game => game, :user => user)}.to change{UserAssignment.count}.by(1)
    expect{UserAssignment.create(:game => game, :user => user)}.to_not change{UserAssignment.count}
  end

  it "should not assign the same power in a game more than once" do
    user2 = Factory.create(:user)
    expect{UserAssignment.create(:game => game, :user => user, :power => game.powers.first)}.to change{UserAssignment.count}.from(0).to(1)
    expect{UserAssignment.create(:game => game, :user => user2, :power => game.powers.first)}.not_to change{UserAssignment.count}
  end

end
# == Schema Information
#
# Table name: user_assignments
#
#  id       :integer         not null, primary key
#  game_id  :integer         not null
#  user_id  :integer         not null
#  power_id :integer
#

