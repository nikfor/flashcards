require 'rails_helper'

describe Pack, type: :model do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }
  let!(:pack_2) { FactoryGirl.create(:pack, user: user, name: "Travel", current: true ) }

  context "#activate!" do

    before :each do
      pack.activate!
    end

    it "should pack do current" do
      expect(pack.current).to be true
    end

    it "should pack_2 do uncurrently" do
      expect(pack_2.reload.current).to be false
    end

  end

  it "should belong to user" do
    expect(pack).to belong_to(:user)
  end

end
