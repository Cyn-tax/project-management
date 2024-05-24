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
FactoryBot.define do
  factory :member do
    first_name { 'Test' }
    last_name { 'Test' }
    city { 'test' }
    country { 'test' }
    state { 'test' }
    association :team
  end
end
