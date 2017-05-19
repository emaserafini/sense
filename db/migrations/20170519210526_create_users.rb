Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :email, String, null: false
      column :username, String, null: false
      column :password_digest, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :email, unique: true
      index :username, unique: true
    end
  end
end
