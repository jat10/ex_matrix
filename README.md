# ExMatrix

![Elixir](https://img.shields.io/badge/Elixir-1.6-green.svg)
[![Hex.pm](https://img.shields.io/badge/hex-v0.1.0-brightgreen.svg)](https://hex.pm/packages/ex_matrix)
[![Read the Docs](https://img.shields.io/badge/Read%20the%20docs-v0.1-brightgreen.svg)](https://hexdocs.pm/ex_matrix/ExMatrix.html#content)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

`ExMatrix` is a new Matrix library for Elixir. This library helps you to create a matrix,
`manipulate` it with values and `add/subtract` two matrices.

## What is a Matrix

A matrix is a collection of numbers arranged into a fixed number of rows and columns.

Here is an example of a `3x2` matrix which means that we have `3 rows` and `2 columns`.

```  
        col 1  col 2
row 1 |  0      1   |
row 2 |  2      7   |
row 3 |  9      0   |
``` 
This is `row 2` 

```
|  2      7   |
```

This is `col 2`

```
  col 2
|   1   |
|   7   |
|   0   |
```

To get value from the above matrix we need to specify the row and colum that we need to get 
the value from. The known syntax is `(number_of_rows,number_of_columns)` 
`(0,1) = 1` and `(2,0) = 9`

## Installation
First, add ExMatrix to your mix.exs dependencies:

```elixir
def deps do
  [
    {:ex_matrix, "~> 0.1.0"}
  ]
end
```

Then, update your dependencies:

```elixir
$ mix deps.get
```

## Elixir Matrix

So to generate an elixir matrix you can use `ExMatrix.create("RowsxColumns")` 
will generate a map that can be used as a matrix

But note that `ExMatrix.create(...)` will generate an empty matrix as you can see in the example

```elixir
  iex> matrix = ExMatrix.create("3x2")
  %{"0" => %{"0" => "", "1" => ""},
    "1" => %{"0" => "", "1" => ""},
    "2" => %{"0" => "", "1" => ""}
  }
```

So to fill this matrix with values you can use `ExMatrix.set_matrix(matrix,data)`

```elixir
  matrix = %{"0" => %{"0" => "0", "1" => "1"},
             "1" => %{"0" => "2", "1" => "7"},
             "2" => %{"0" => "9", "1" => "0"}
            }
```
Now you can get values `matrix["0"]["1"] = 1` and `matrix["2"]["0"] = 9`.

## Adding or Subtracting two matrices

There are many operation that you can apply on matrices and one of these operations is to add
and subtract two matrices.

Small review on how we deal with addition and subtraction of two matrices:

```
   Matrix A     +      Matrix B     =     Result 
|  0      1   |   |  1      -1   |   |  1      0   |
|  2      7   |   |  7      -2   |   |  9      5   |
|  9      0   |   |  -1      8   |   |  8      8   |
```

You can use `ExMatrix.add_matrices(matrix_1,matrix_2)` or `ExMatrix.sub_matrices(matrix_1,matrix_2)`  

## Example Function

In case that there is something vague please use a helper function

```elixir
  iex> ExMatrix.example("2x2")
  %{"0" => %{"0" => "(0,0)", "1" => "(0,1)"},
    "1" => %{"0" => "(1,0)", "1" => "(1,1)"}
  }
```

## What's Next
This library will be extend to have the ability to:
1. Add or subtract two or more matrices
1. Multiply and Divide two or more matrices
1. Matrix Transpose


## For contribution on GitHub
Please read the contribution requirements before start working


## Copyright and License

Copyright (c) 2018, Jad Tarabay.

ExMatrix source code is licensed under the [MIT License](LICENSE).

