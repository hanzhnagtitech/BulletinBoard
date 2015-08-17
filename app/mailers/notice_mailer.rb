class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  default from: "han.zhang@techouse.jp"

  def sendmail_confirm(message)
    @message = message
    @to_mail_user = Message.where('id = ?', @message.reply_id).first.user
    if @to_mail_user
      mail(
        to: @to_mail_user.email,
        subject: 'You got a reply'
      )
    end
  end
end