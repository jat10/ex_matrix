defmodule ExMatrix do
  @moduledoc """
  Documentation for ExMatrix.
  """

  @doc """
  Create

  ## Examples

      iex> ExMatrix.create("2x2")
      %{"0" => %{"0" => "", "1" => ""},
        "1" => %{"0" => "", "1" => ""}
      }
  """
  def create(name) do
    Helper.create_map_matrix(name)
  end

   @doc """
  Set Matrix

  ## Examples
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
  Example

  ## Examples

      iex> ExMatrix.example("2x2")
      %{"0" => %{"0" => "(0,0)", "1" => "(0,1)"},
        "1" => %{"0" => "(1,0)", "1" => "(1,1)"}
      }
  """
  def example(matrix) do
    Helper.example(matrix)
  end

  def change_type(matrix,type) do
    Helper.change_type(matrix,type)
  end

  def add_matrices(matrix_1, matrix_2) do
    Helper.add_sub_matrix(matrix_1, matrix_2,"add")
  end

  def sub_matrices(matrix_1, matrix_2) do
    Helper.add_sub_matrix(matrix_1, matrix_2,"sub")
  end
end
