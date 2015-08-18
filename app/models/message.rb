class Message < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true

  def self.message_list
    return Message.all.order(:created_at => :desc)
  end
end
