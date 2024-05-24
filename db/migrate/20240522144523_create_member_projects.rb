# frozen_string_literal: true

class CreateMemberProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :member_projects do |t|
      t.references :member, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.index %i[member_id project_id], unique: true
      t.timestamps
    end
  end
end
