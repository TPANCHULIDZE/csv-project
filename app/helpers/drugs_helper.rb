# frozen_string_literal: true

module DrugsHelper
  def deadline(drug)
    drug.deadline.strftime('%d/%m/%Y')
  end

  def is_expired?(drug)
    drug.deadline < Time.zone.now ? 'Expired' : 'Not Expired'
  end
end
