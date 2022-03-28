import Config

config :acs_ex, :acs_port, 7548
config :acs_ex,
  crypt_keybase: "31de9f7d766287c7565801f30babbd4f",
  crypt_cookie_salt: "SomeSalt",
  crypt_signed_cookie_salt: "SomeSignedSalt"

config :logger, level: :warn
