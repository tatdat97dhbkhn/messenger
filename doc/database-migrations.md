## Database migrations

All migrations are stored in [migrate](./db/migrate) dir.
Database configuration is defined in [database.yml](./config/database.yml).
DB credentials are taken from env variables or .env file.

There are several scripts that will help you work with migrations:

- To create a new migration you have to use `make bash` and `rails g migrration $Name` where `$NAME` is the name that you would like to define for migration.
  The command will create a new migration file in [migrate](./db/migrate) dir. The migration file has two methods `up` and `down`.
  Method `up` should be responsible for applying changes to the database.
  Method `down` should be responsible for rolling back the changes introduced by `up` method.
  Both methods should be implemented.

- To apply the migration that was created on previous step you have to use `make migrate` or `make bash -> rails db:migrate`.

- To rollback the last applied migration you have to use `rails db:migrate:down VERSION=$VERSION`

