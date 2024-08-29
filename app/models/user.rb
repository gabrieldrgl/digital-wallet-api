class User < ApplicationRecord
  has_secure_password
  has_many :transactions

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_email

  def balance
    transactions.deposit.sum(:amount) - transactions.withdrawal.sum(:amount)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
