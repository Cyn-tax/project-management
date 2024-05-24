# frozen_string_literal: true

class AddTeamToMember < ActiveRecord::Migration[7.1]
  def change
    add_reference :members, :team, index: true
  end
end
