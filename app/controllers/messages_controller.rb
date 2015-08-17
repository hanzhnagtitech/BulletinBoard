class MessagesController < ApplicationController
  #before_filter :authenticate_user!

  def index
    # @messages = Message.message_list
    # if params[:word].present?
    #   @messages = @messages.where('body like ?', "%#{params[:word]}%")
    # end
    @q = Message.search(params[:q])
    @messages = @q.result(distinct: true).message_list.page(params[:page]).per(10)
  end
    
  def new
    @message = Message.new
  end
  
  def show
    @message = Message.where(:id => params[:id]).first
  end
  
  def edit
    @message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to :action => :index 
    else
      render :action => 'edit'
    end
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save && @message.reply_id.present?
      NoticeMailer.sendmail_confirm(@message).deliver
      redirect_to :action => :index
    elsif @message.save
      redirect_to :action => :index
    else
      @messages = Message.message_list
      render :action => 'new'
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to :action => :index
    else
      redirect_to :action => :index
    end
  end

  def confirm
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end
  
  
  def reply
    @message = Message.new
    @message.user = current_user
    @message.reply_id = params[:id]
  end

  private
    def message_params
      params.require(:message).permit(:reply_id, :title, :body, :image, :image_cache)
    end
end
