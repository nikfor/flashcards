require 'rails_helper'

describe Pack, type: :model do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }

  it "should belong to user" do
    expect(pack).to belong_to(:user)
  end

end
