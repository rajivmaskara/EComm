class Notification < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.order_confirmation.subject
  #
  def order_confirmation(order)
    @order = order

    @greeting = "Hi #{@order.user.username}"

    mail to: @order.user.email, subject: "Your order has been confirmed (Order # #{@order.order_number})"
  end

  def welcome_user_message(user)
    @user = user
    mail to: @user.email, subject: "Thanks for signing up"

  end

end
