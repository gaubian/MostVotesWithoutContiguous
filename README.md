# Maximum number of electoral votes without contiguous states

## Why ?

A little OCaml code to answer this quora question : https://www.quora.com/Is-it-possible-to-accumulate-270-electoral-votes-with-no-contiguous-states

## How does this work ?

There's a map of the USA given by the file graph_US.txt.
The OCaml code is compiled as usal by ocamlbuild/ocamlc/... It waits for the input graph to be in stdin. Thus, you use this with something like :

    ./a.out < graph_US.txt

## What's the result ?

It shows us the best solution for this problem, which gives 272 votes ! It has been illustrated in final_map.png?

## How does this work ?

It's a simple backtracking algorithm with dynamic programming.