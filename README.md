# PayPing

[comment]: <> "[![Build Status](https://travis-ci.org/msudgh/payping.svg?branch=master)](https://travis-ci.org/msudgh/payping) [![Inline docs](https://inch-ci.org/github/msudgh/payping.svg)](https://inch-ci.org/github/msudgh/payping) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/payping) [![Coverage Status](https://coveralls.io/repos/github/msudgh/payping/badge.svg?branch=master)](https://coveralls.io/github/msudgh/payping?branch=master) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/msudgh/payping.svg)](https://beta.hexfaktor.org/github/msudgh/payping) [![hex.pm version](https://img.shields.io/hexpm/v/payping.svg)](https://hex.pm/packages/payping) [![hex.pm downloads](https://img.shields.io/hexpm/dt/payping.svg)](https://hex.pm/packages/payping) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)"

PayPing API client for the Elixir language

## Installation

The package can be installed by adding `payping` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:payping, "~> 0.1.0"}
  ]
end
```

## Configuration

`:payping` can be configured in your `config/config.exs` or `config/{env}.exs` file:

```exs
config :payping,
  token: "Bearer YOUR_TOKEN",
  base_url: "https://api.payping.ir" # Optional
```

## TODO

- [ ] Payment

  - [x] POST /v2/pay
  - [x] POST /v2/pay/verify
  - [ ] POST /v2/pay/multi
  - [ ] POST /v2/pay/BlockMoney
  - [ ] POST /v2/pay/pos
  - [ ] POST /v2/pay/{code}
