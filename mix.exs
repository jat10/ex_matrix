defmodule ExMatrix.MixProject do
  use Mix.Project

  @version "0.1.0"
  @name "ex_matrix"
  @maintainers ["Jad Tarabay"]
  @url "https://github.com/jat10/ex_matrix"

  def project do
    [
      app: :ex_matrix,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: @name,
      source_url: @url 
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description() do 
    "ExMatrix is a new Matrix library for Elixir. This library helps you to create a matrix,manipulate it with values and add/subtract two matrices." 
  end 

  defp package() do 
    [ 
      # This option is only needed when you don't want to use the OTP application name 
      name: @name,
      # These are the default files included in the package 
      files: ["lib", "mix.exs", "README*", "LICENSE*"], 
      maintainers: @maintainers, 
      licenses: ["MIT"],
      links: %{"GitHub" => @url}
    ] 
  end 
end
