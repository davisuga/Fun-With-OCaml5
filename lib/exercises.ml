let n = try int_of_string Sys.argv.(1) with _ -> 40

let rec fib n = if n < 2 then 1 else fib (n - 1) + fib (n - 2)

let is_odd n = n mod 2 == 1

let fib_par n =
  if n > 20 then begin
      let ta = Domain.spawn (fun _ -> fib (n - 3) ) in
      let tb = Domain.spawn (fun _ -> fib (n - 2) ) in 
      let r2 = Domain.join ta in
      let r1 = Domain.join tb in
      r1 + r2
  end else fib n

let run () =
  let r = fib_par n in
  Printf.printf "fib(%d) = %d\n%!" n r
