import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :midterm, Midterm.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "midterm_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :midterm, MidtermWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5hHtY2YBP9HE4p3lHcyXcJ6mSyamHZeY8hm+9N6C+6WIRddDhxcBDchi1IS27IRs",
  server: false

# In test we don't send emails.
config :midterm, Midterm.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
