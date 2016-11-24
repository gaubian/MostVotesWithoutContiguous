module SMap = Map.Make(String)
module SSet = Set.Make(String)
module SSMap = Map.Make(SSet)


let rec f grph votes still dyn =
    if SSMap.mem still !dyn
    then SSMap.find still !dyn
    else let x = SSet.choose still in
         let nei = SMap.find x grph in
         let vote_x = SMap.find x votes in
         let without_x = f grph votes (SSet.remove x still) dyn in
         let with_x = f grph votes SSet.(diff (remove x still) nei) dyn in
         let ans =
            if vote_x + fst with_x > fst without_x
            then (vote_x + fst with_x, SSet.add x (snd with_x))
            else without_x
         in
         let () = dyn := SSMap.add still ans !dyn in
            ans

let rec parse_one_line set = function
    | 0 ->  set
    | m ->  parse_one_line (Scanf.scanf " %s" (fun x -> SSet.add x set))
            (m-1)

let rec parse grph votes still = function
    | 0 ->  (grph, votes, still)
    | n ->  let (stt,vote,m) = Scanf.scanf " %s %d %d" (fun stt vote m ->
                (stt,vote,m))
            in
            let nei = parse_one_line (SSet.singleton stt) m in
                parse (SMap.add stt nei grph) (SMap.add stt vote votes)
                (SSet.add stt still) (n-1)

let _ =
    let dyn = ref (SSMap.singleton SSet.empty (0,SSet.empty)) in
    let n = Scanf.scanf "%d" (fun n -> n) in
    let (grph,votes,still) = parse SMap.empty SMap.empty SSet.empty n in
    let result = f grph votes still dyn in
        Printf.printf "%d\n" (fst result);
        SSet.iter (Printf.printf " %s") (snd result);
        Printf.printf "\n"