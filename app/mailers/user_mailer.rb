class UserMailer < ApplicationMailer
  def checkout_success(user, order)
    @order = order
    @user = user
    mail(to: @user.email, subject: 'Successful Order')
  end
end
