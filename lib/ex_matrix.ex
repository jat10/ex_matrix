defmodule ExMatrix do
  @moduledoc """
    
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

  ## Elixir Matrix

  So to generate an elixir matrix you can use `ExMatrix.create("RowsxColumns")` 
  will generate a map that can be used as a matrix

  But note that `ExMatrix.create(...)` will generate an empty matrix as you can see in the example

  ```
      iex> matrix = ExMatrix.create("3x2")
      %{"0" => %{"0" => "", "1" => ""},
        "1" => %{"0" => "", "1" => ""},
        "2" => %{"0" => "", "1" => ""}
      }
  ```

  So to fill this matrix with values you can use `ExMatrix.set_matrix(matrix,data)`

  ```
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
      Matrix A    +    Matrix B      =     Result 
  |  0      1   |   |  1      -1   |   |  1      0   |
  |  2      7   |   |  7      -2   |   |  9      5   |
  |  9      0   |   |  -1      8   |   |  8      8   |
  ```

  You can use `ExMatrix.add_matrices(matrix_1,matrix_2)` or `ExMatrix.sub_matrices(matrix_1,matrix_2)`  

  ## Example Function

  In case that there is something vague please use a helper function

  ```
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

  For more information please check the [github](https://github.com/jat10/ex_matrix)

  ## For contribution on GitHub
  Please read the contribution requirements before start working
  """

  @doc """
  Create a matrix

  ## Example

      iex> ExMatrix.create("2x2")
      %{"0" => %{"0" => "", "1" => ""},
        "1" => %{"0" => "", "1" => ""}
      }
  """
  def create(name) do
    Helper.create_map_matrix(name)
  end

   @doc """
  Set values to the base matrix

  ## Example
      iex> matrix = ExMatrix.create("2x2")
      iex> data = [{"(0,0)","1"},{"(0,1)","2"},{"(1,0)","3"},{"(1,1)","4"}]
      iex> ExMatrix.set_matrix(matrix,data)
      %{"0" => %{"0" => "1", "1" => "2"},
        "1" => %{"0" => "3", "1" => "4"}
      }
  """
  def set_matrix(matrix,data) do
    Helper.set_matrix_data(matrix,data)
  end


  @doc """
  Helper function to undestand how elixir matrix is generated

  ## Example

      iex> ExMatrix.example("2x2")
      %{"0" => %{"0" => "(0,0)", "1" => "(0,1)"},
        "1" => %{"0" => "(1,0)", "1" => "(1,1)"}
      }
  """
  def example(matrix) do
    Helper.example(matrix)
  end

  @doc """
  Change type of values in the martix

  When you generate an elixir matrix the type of values will be in string, in case you need change
  this function gives you the ability to change them only for integers only.

  ## Example

      iex> ExMatrix.example("2x2")
      %{"0" => %{"0" => "(0,0)", "1" => "(0,1)"},
        "1" => %{"0" => "(1,0)", "1" => "(1,1)"}
      }
  """
  def change_type(matrix,type) do
    Helper.change_type(matrix,type)
  end

  @doc """
  Add two matrices

  You can add two matrices with string values or integers value where the return matrix will be the
  same type of the two matrices.

  ## Example
      iex> matrix_1 = %{"0" => %{"0" => 2, "1" => 7},"1" => %{"0" => 4, "1" => 4}}
      iex> matrix_2 = %{"0" => %{"0" => 8, "1" => 3},"1" => %{"0" => 6, "1" => 0}}
      iex> ExMatrix.add_matrices(matrix_1,matrix_2)
      %{"0" => %{"0" => 10, "1" => 10},
        "1" => %{"0" => 10, "1" => 4}
      }
  """
  def add_matrices(matrix_1, matrix_2) do
    Helper.add_sub_matrix(matrix_1, matrix_2,"add")
  end

  @doc """
  Subtract two matrices

  You can subtract two matrices with string values or integers value where the return matrix will be the
  same type of the two matrices.


  ## Example

      iex> matrix_1 = %{"0" => %{"0" => "2", "1" => "7"},"1" => %{"0" => "4", "1" => "4"}}
      iex> matrix_2 = %{"0" => %{"0" => "8", "1" => "3"},"1" => %{"0" => "6", "1" => "0"}}
      iex> ExMatrix.sub_matrices(matrix_1,matrix_2)
      %{"0" => %{"0" => "-6", "1" => "4"},
        "1" => %{"0" => "-2", "1" => "4"}
      }
  """
  def sub_matrices(matrix_1, matrix_2) do
    Helper.add_sub_matrix(matrix_1, matrix_2,"sub")
  end
end
