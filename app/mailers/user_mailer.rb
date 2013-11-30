class UserMailer < ActionMailer::Base
  default from: "tristaronlineservice@gmail.com"

  def winningbid(provider, customer)
      @provuser = provider
      @requestuser = customer
      mail(:to => provider.email, :subject => "Congratulations!!! Service Request bid has been accepted.")
  end
  def awardbid(provider, user)
      @provuser1 = provider
      @requestuser1 = user
      mail(:to => user.email, :subject => "You have selected your Service Provider.")
  end
  #def losingbid(provider, user, item)
   #   @provuser2 = provider
   #   @requestuser2 = user
   #   @item = item
   #   mail(:to => user.email, :subject => "Service request bid not accepted")
  #end
end
