# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(250) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(2).is_at_most(250) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(50) }
  end
end
