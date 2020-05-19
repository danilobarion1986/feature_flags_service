# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:your_model) do
      primary_key :id
      String :name, null: false
    end
  end

  down do
    drop_table(:your_model)
  end
end
