class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  before_validation :downcase_email, :on => :save
  after_validation :set_token, :on => :create

  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}

  def set_token
    self.token = SecureRandom.uuid
  end

  def downcase_email
    self.email = self.email.downcase
  end
end
