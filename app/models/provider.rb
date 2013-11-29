class Provider < ActiveRecord::Base

  validates :username, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

       has_many :servicerequests
       has_many :bids
       has_many :users, through: :servicerequests

end
