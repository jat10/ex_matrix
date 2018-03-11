defmodule ExMatrixTest do
  use ExUnit.Case
  doctest ExMatrix

  test "create matrix" do
  	matrix = ExMatrix.create("2x2")
  	assert matrix == %{"0" => %{"0" => "", "1" => ""},
  					   "1" => %{"0" => "", "1" => ""}
  					  }
  end

  test "set matrix" do
  	matrix = ExMatrix.create("2x2")
  	data = [{"(0,0)","1"},{"(0,1)","2"},{"(1,0)","3"},{"(1,1)","4"}]
  	new_matrix = ExMatrix.set_matrix(matrix,data)
  	assert new_matrix == %{"0" => %{"0" => "1", "1" => "2"},
  						   "1" => %{"0" => "3", "1" => "4"}
  						  }
  end

  test "get values" do
  	matrix = %{"0" => %{"0" => "1", "1" => "2"},
  			   "1" => %{"0" => "3", "1" => "4"}
  			  }
	assert matrix["0"]["1"] == "2"
  end

  test "example" do
  	matrix = ExMatrix.example("2x2")
  	assert matrix == %{"0" => %{"0" => "(0,0)", "1" => "(0,1)"},
  					   "1" => %{"0" => "(1,0)", "1" => "(1,1)"}
  					  }
  end

  test "change type of the matrix to integer" do
  	matrix = %{"0" => %{"0" => "1", "1" => "2"},
  			   "1" => %{"0" => "3", "1" => "4"}
  			  }
  	new_matrix = ExMatrix.change_type(matrix,"integer")
	assert new_matrix == %{"0" => %{"0" => 1, "1" => 2},
						   "1" => %{"0" => 3, "1" => 4}
						  }
  end


  test "change type of the matrix to string" do
  	matrix = %{"0" => %{"0" => 1, "1" => 2},
  			   "1" => %{"0" => 3, "1" => 4}
  			  }
  	new_matrix = ExMatrix.change_type(matrix,"string")
	assert new_matrix == %{"0" => %{"0" => "1", "1" => "2"},
						   "1" => %{"0" => "3", "1" => "4"}
						  }
  end

  test "addition of two matrices string type" do
  	matrix_1 = %{"0" => %{"0" => "2", "1" => "7"},
  			     "1" => %{"0" => "4", "1" => "4"}
  			    }
  	matrix_2 = %{"0" => %{"0" => "8", "1" => "3"},
  			     "1" => %{"0" => "6", "1" => "0"}
  			    }

  	result = ExMatrix.add_matrices(matrix_1, matrix_2)
  	assert result == %{"0" => %{"0" => "10", "1" => "10"},
  			    	   "1" => %{"0" => "10", "1" => "4"}
  			    	  }
  end

  test "addition of two matrices integer type" do
  	matrix_1 = %{"0" => %{"0" => 2, "1" => 7},
  			     "1" => %{"0" => 4, "1" => 4}
  			    }
  	matrix_2 = %{"0" => %{"0" => 8, "1" => 3},
  			     "1" => %{"0" => 6, "1" => 0}
  			    }
  	result = ExMatrix.add_matrices(matrix_1, matrix_2)
  	assert result == %{"0" => %{"0" => 10, "1" => 10},
  			    	   "1" => %{"0" => 10, "1" => 4}
  			    	  }
  end

  test "subtract of two matrices string type" do
  	matrix_1 = %{"0" => %{"0" => "2", "1" => "7"},
  			     "1" => %{"0" => "4", "1" => "4"}
  			    }
  	matrix_2 = %{"0" => %{"0" => "8", "1" => "3"},
  			     "1" => %{"0" => "6", "1" => "0"}
  			    }
  	result = ExMatrix.sub_matrices(matrix_1, matrix_2)
  	assert result == %{"0" => %{"0" => "-6", "1" => "4"},
  			    	   "1" => %{"0" => "-2", "1" => "4"}
  			    	  }
  end

  test "subtract of two matrices integer type" do
  	matrix_1 = %{"0" => %{"0" => 2, "1" => 7},
  			     "1" => %{"0" => 4, "1" => 4}
  			    }
  	matrix_2 = %{"0" => %{"0" => 8, "1" => 3},
  			     "1" => %{"0" => 6, "1" => 0}
  			    }
  	result = ExMatrix.sub_matrices(matrix_1, matrix_2)
  	assert result == %{"0" => %{"0" => -6, "1" => 4},
  			    	   "1" => %{"0" => -2, "1" => 4}
  			    	  }
  end


end
