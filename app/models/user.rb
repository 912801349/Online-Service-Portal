class User < ActiveRecord::Base
    #:token_authenticatable, :lockable
    # :confirmable - do not want user to confirm with email receivd
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :lockable
  has_many :servicerequests
  has_many :providers, through: :servicerequests
  
end
