class WelcomeController < ApplicationController
  def index
    redirect_to messages_url if current_user.present?
  end
end
