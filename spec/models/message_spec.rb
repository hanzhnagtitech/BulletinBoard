require 'rails_helper'

describe Message do
  
  it "is invalid without title" do
    message = Message.new(title: nil)
    message.valid?
    expect(message.errors[:title]).to include("can't be blank")
  end
  
  it "is valid with title" do
    message = Message.new(title: 'test')
    expect(message).to be_valid
  end
 
end