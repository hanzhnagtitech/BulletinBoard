class Message < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :title, :presence => true

  
  def self.message_list
    return Message.all.order(:created_at => :desc)
  end
end
