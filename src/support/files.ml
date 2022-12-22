let read_lines file =
  let contents = In_channel.with_open_bin file In_channel.input_all in
  String.split_on_char '\n' contents

let go finalize body =
  try
    let x = body () in
    finalize ();
    x
  with
  | e ->
      finalize ();
      raise e

let with_temp_file temp_dir basename f =
  let path, out = Filename.open_temp_file ~temp_dir basename "" in
  let finalize () =
    List.iter
      (fun f -> Misc.noexcept f)
      [ (fun () -> close_out out); (fun () -> Sys.remove path) ]
  in
  go finalize (fun () -> f path out)

let with_in_channel path f =
  let input = open_in path in
  let finalize () = Misc.noexcept (fun () -> close_in input) in
  go finalize (fun () -> f input)
