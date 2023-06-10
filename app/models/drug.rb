# frozen_string_literal: true

class Drug < ApplicationRecord
  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 250 }

  validates :amount,
            presence: true,
            numericality: { only_integer: true }

  validates :price,
            presence: true,
            numericality: true

  validates :description,
            presence: true,
            length: { minimum: 2, maximum: 100_000 }

  validates :deadline,
            presence: true

  validates :company,
            presence: true,
            length: { minimum: 2, maximum: 250 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount company deadline description name price]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
