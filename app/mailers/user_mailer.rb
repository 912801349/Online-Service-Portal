class UserMailer < ActionMailer::Base
  default from: "tristaronlineservice@gmail.com"

  def winningbid(user,customer)
      @provuser = user
      @requestuser = customer
      mail(:to => user.email, :subject => "Service request bid accepted")
  
  end
  def awardbid(provider,user)
      @provuser1 = provider
      @requestuser1 = user
      mail(:to => user.email, :subject => "Service request bid awarded")
  end
  def losingbid(provider, user, item)
      @provuser2 = provider
      @requestuser2 = user
      @item = item
      mail(:to => user.email, :subject => "Service request bid not accepted")
  end


end
