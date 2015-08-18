require 'rails_helper'

describe Message do
  
  it "is invalid without title" do
    message = build(:invalid_message)
    message.valid?
    expect(message.errors[:title]).to include("can't be blank")
  end
  
  it "is valid with title" do
    expect(build(:message)).to be_valid
  end
 
end