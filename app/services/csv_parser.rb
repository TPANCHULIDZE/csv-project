# frozen_string_literal: true

require 'csv'
class CsvParser
  def call(file)
    tempfile = file.tempfile
    options = { headers: true, col_sep: ';' }
    @countity = 0

    CSV.foreach(tempfile, **options) do |row|
      drug_hash = generate_drug_hash(row)

      update_or_create(drug_hash)
    end

    @countity
  end

  private

  def generate_drug_hash(row)
    drug_hash = {}

    drug_hash[:name] = row['name']
    drug_hash[:amount] = row['amount']
    drug_hash[:price] = row['price']
    drug_hash[:deadline] = row['deadline']
    drug_hash[:description] = row['description']
    drug_hash[:company] = row['company']

    drug_hash
  end

  def update_or_create(drug_hash)
    amount = drug_hash.delete :amount
    description = drug_hash.delete :description
    drug = Drug.find_by(drug_hash)

    if drug.present?
      drug.update(amount: drug.amount + amount.to_i, description:)
    else
      Drug.create(drug_hash.merge(amount:, description:))
    end

    @countity += 1
  rescue StandardError => _e
  end
end
