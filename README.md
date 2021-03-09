# Sample GraphQL Application

A sample Flutter app showing both REST and GraphQL implementations of querying. 

## Steps for Backend
1. Go to backend/
1. npm install
1. Create a database
1. Add initial users in `persons` table to database
1. Create .env file and add the following variables: `PG_USER`, `PG_PASSWORD`, `PG_DATABASE`, `PG_DATABASE_DEV` with your corresponding details.
1. npx knex migrate:latest

## Steps for UI
1. Go to ui/
1. `flutter pub get`
1. Launch emulator
1. `flutter run`

**Note: This is not optimized**
