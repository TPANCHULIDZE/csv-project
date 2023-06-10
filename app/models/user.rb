# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_REGEX = /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 250 }

  validates :email,
            presence: true,
            length: { minimum: 2, maximum: 250 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: true,
            length: { minimum: 8, maximum: 50 },
            format: { with: PASSWORD_REGEX }
end
