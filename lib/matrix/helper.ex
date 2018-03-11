defmodule Helper do
	require Logger
	
	def create_map_matrix(name) do
		matrix_base(name)
	end

	def example(name) do
		matrix_base(name,"example")
	end

	def set_matrix_data(matrix,data) do
		# [{"(3,3)","10"},{"(0,1)","2"},{"(1,1)","1"}]
		data
		|> Enum.reduce(matrix,fn(x,acc) ->
			position = elem(x,0)
			val = elem(x,1)
			set_matrix(acc,position,val)
		end)
	end

	defp set_matrix(matrix,position,data) do
		list = position |> String.split(",")
		row = Enum.at(list,0) |> String.split("(") |> Enum.at(1) |> String.to_integer
		col = Enum.at(list,1) |> String.split(")") |> Enum.at(0) |> String.to_integer
		new_col = Map.put(matrix["#{row}"],"#{col}",data)
		Map.put(matrix,"#{row}",new_col)
	end

	def matrix_base(name,val \\ "") do
		{row,col} = get_list(name,"name")
		list_row = elem(row,0)
		col_count = elem(col,1)

		{ map_row, _ } = Enum.reduce(list_row,{%{},0},fn(_,acc) -> 
			acc_0 = elem(acc,0)
			acc_1 = elem(acc,1)
			acc_0 = Map.put_new(acc_0,"#{acc_1}",%{})
			{acc_0,acc_1+1}
		end) 

		{ matrix, _ } = Enum.reduce(list_row,{map_row,0},fn(_,acc) -> 
			acc_0 = elem(acc,0)
			acc_1 = elem(acc,1)
			{main_data, _} = for i <- 0..(col_count - 1) do
				case val do
					"" ->
						""
					"example" ->
						"(#{acc_1},#{i})"
				end
			end
			|> Enum.reduce({%{},0},fn(x,ack) -> 
				ack_0 = elem(ack,0)
				ack_1 = elem(ack,1)
				ack_0 = Map.put_new(ack_0,"#{ack_1}",x)
				{ack_0,ack_1+1}
			end)

			acc_0 = Map.put(acc_0,"#{acc_1}",main_data)
			{acc_0,acc_1+1}
		end) 

		matrix
	end

	def change_type(matrix,type) do
		{row,col} = get_list(matrix,"matrix")
		list_row = elem(row,0)
		list_col = elem(col,0)
		{ new_matrix, _} = Enum.reduce(list_row,{%{},0},fn(_,acc) -> 
			new_matrix = elem(acc,0)
			row = elem(acc,1)
			{col_map, _} = Enum.reduce(list_col,{%{},0},fn(_,acc1) -> 
				col_map = elem(acc1,0)
				col = elem(acc1,1)
				col_map = case type do
					"integer" ->
						Map.put_new(col_map,"#{col}",String.to_integer(matrix["#{row}"]["#{col}"]))
					"string" ->
						Map.put_new(col_map,"#{col}",Integer.to_string(matrix["#{row}"]["#{col}"]))
				end
				{col_map,col+1}
			end)

			new_matrix = Map.put_new(new_matrix,"#{row}",col_map)
			{new_matrix,row+1}
		end) 
		new_matrix
	end

	defp get_list(data,type) do
		{row_count,col_count} = case type do
			"matrix" ->
				{Enum.count(data),Enum.count(data["0"])}
			"name" ->
				list = data |> String.split("x")
				num_row = Enum.at(list,0) |> String.to_integer
				num_col = Enum.at(list,1) |> String.to_integer
				{num_row,num_col}
		end

		list_row = for _ <- 0..(row_count - 1) do
			""
		end

		list_col = for _ <- 0..(col_count - 1) do
			""
		end

		{{list_row,row_count},{list_col,col_count}}
	end

	def test(type) do
		matrix_1 = ExMatrix.create("2x2")
		matrix_2 = ExMatrix.create("2x2")

		matrix_1 = Helper.set_matrix_data(matrix_1,[{"(0,0)","2"},{"(0,1)","4"},{"(1,0)","15"},{"(1,1)","6"}])
		matrix_2 = Helper.set_matrix_data(matrix_2,[{"(0,0)","12"},{"(0,1)","2"},{"(1,0)","1"},{"(1,1)","4"}])

		add_sub_matrix(matrix_1,matrix_2,type)
	end

	def add_sub_matrix(matrix_1,matrix_2,type_of_operation) do
		case(required_op(matrix_1,matrix_2)) do
			{:ok,info} ->
				{ new_matrix, _} = Enum.reduce(elem(info.matrix_1.row,0),{%{},0},fn(_,acc) -> 
					new_matrix = elem(acc,0)
					row = elem(acc,1)
					{col_map, _} = Enum.reduce(elem(info.matrix_1.col,0),{%{},0},fn(_,acc1) -> 
						col_map = elem(acc1,0)
						col = elem(acc1,1)
						type = check_type(matrix_1["#{row}"]["#{col}"])		
						op_result = calculate({
							matrix_1["#{row}"]["#{col}"],
							matrix_2["#{row}"]["#{col}"]
							},type_of_operation,type)
						col_map = Map.put_new(col_map,"#{col}",op_result)
							
						{col_map,col+1}
					end)
					new_matrix = Map.put_new(new_matrix,"#{row}",col_map)
					{new_matrix,row+1}
				end) 
				new_matrix
			{:error, reason} ->
				{:error, reason}
		end
 	end

 	defp calculate(numbers,operation,type) do
 		{num_1,num_2}= case type do
 			"string" ->
 				{String.to_integer(elem(numbers,0)),String.to_integer(elem(numbers,1))}
 			"integer" ->
 				{elem(numbers,0),elem(numbers,1)}
 			"" ->
 				{0,0}
 		end

 		result = case operation do
 			"sub" ->
 				num_1 - num_2
 			"add" ->
 				num_1 + num_2
 		end

 		case type do
 		  "string" ->
 		    Integer.to_string(result)
 		  "integer" ->
 		   	result
 		end
 	end

 	defp check_type(val) do
 		if(:erlang.is_bitstring(val)) do
			"string"
		else
			if(:erlang.is_integer(val)) do
				"integer"
			else
				Logger.error("The type is not integer or string")
				""
			end
		end
 	end

 	defp required_op(matrix_1,matrix_2) do
 		{row_1,col_1} = get_list(matrix_1,"matrix")
		{row_2,col_2} = get_list(matrix_2,"matrix")
		data = %{matrix_1: %{row: row_1,col: col_1},
	      matrix_2: %{row: row_2,col: col_2}
	  	}

		dec = if((elem(row_1,1) == elem(row_2,1)) && (elem(col_1,1) == elem(col_2,1))) do
			{:ok, data}
		else
			reason = "Matrix 1 #{elem(row_1,1)}x#{elem(col_1,1)} different from Matrix 2 #{elem(row_2,1)}x#{elem(col_2,1)} "
			Logger.error(reason)
			{:error, reason}
		end
 	end

	def print() do
		# IO.puts("i \\j     0      1      2      3  ")
		# IO.puts("0      (0,0)  (0,1)  (0,2)  (0,3)")
		# IO.puts("1      (1,0)  (1,1)  (1,2)  (1,3)")
		# IO.puts("2      (2,0)  (2,1)  (2,2)  (2,3)")	
		# IO.puts("3      (3,0)  (3,1)  (3,2)  (3,3)")				
	end
end