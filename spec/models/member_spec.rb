# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  city       :string
#  state      :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'associations' do
    it { should have_many(:member_projects) }
    it { should belong_to(:team) }
    it { should have_many(:projects).through(:member_projects) }
  end
end
