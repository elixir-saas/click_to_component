import Config

config :phoenix, :json_library, Jason
config :logger, :level, :debug
config :logger, :backends, []

if Mix.env() == :dev do
  esbuild = fn args ->
    [
      args: ~w(./js/click_to_command --bundle) ++ args,
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.12.15",
    module:
      esbuild.(~w(--format=esm --sourcemap --outfile=../priv/static/click_to_command.esm.js)),
    main: esbuild.(~w(--format=cjs --sourcemap --outfile=../priv/static/click_to_command.cjs.js)),
    cdn:
      esbuild.(
        ~w(--format=iife --target=es2016 --global-name=LiveView --outfile=../priv/static/click_to_command.js)
      ),
    cdn_min:
      esbuild.(
        ~w(--format=iife --target=es2016 --global-name=LiveView --minify --outfile=../priv/static/click_to_command.min.js)
      )
end
