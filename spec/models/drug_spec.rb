# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Drug do
  subject(:drug) { create(:drug) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(250) }
    it { should validate_presence_of(:company) }
    it { should validate_length_of(:company).is_at_least(2).is_at_most(250) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).only_integer }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(2).is_at_most(100_000) }
    it { should validate_presence_of(:deadline) }
    it { should validate_numericality_of(:price) }
    it { should validate_presence_of(:price) }
  end

  describe 'ransack' do
    let(:ransack_attr) { %w[name price company amount deadline description].sort }
    let(:ransack_assoc) { %w[] }

    it 'have ransackable attributes' do
      expect(described_class.ransackable_attributes.sort).to eq(ransack_attr)
    end

    it 'have ransackable associations' do
      expect(described_class.ransackable_associations.sort).to eq(ransack_assoc)
    end
  end
end
