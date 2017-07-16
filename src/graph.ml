open Core

module type Node = sig
    type t
    val equal   : t -> t -> bool
    val compare : t -> t -> int
end

module type Graph_intf = functor (N : Node) -> sig
   type node = N.t
   type t
   val nodes : t -> node list
   (*val from_edge_list : (node * node) list -> t*)
end

(* List all edges, an edge being a pair of nodes *)
module Edge_list (N : Node) : Graph_intf = struct
  type node = N.t
  type t = (node * node) list

  let equal = N.equal

  let nodes t = List.fold t ~init:[]
      ~f:(fun acc (x, _) -> if (List.mem acc x ~equal) then acc else x :: acc)

end

(* Graph term form: nodes and edges *)
module Graph_term (N : Node) : Graph_intf = struct
    type node = N.t
    module El = Edge_list(N)
    type t = { nodes : node list; edges : El.t }

    let nodes t = t.nodes

    let from_edge_list el =
      let edges = El.from_edge_list el in
      let nodes = El.nodes edges in
      { nodes ; edges }
end

(* List of nodes and the nodes which they share an edge with *)
module Adja_list (N : Node) : Graph_intf = struct
    type node = N.t
    type t = (node * node list) list

    let equal = N.equal

    let nodes t =
      List.fold t ~init:[]
        ~f:(fun acc p ->
            let n = fst p in
            if (List.mem acc n ~equal) then acc else n :: acc)

    let from_edge_list el = el
end

(* Conversions.
 *
 * Write functions to convert between the different graph representations.
 * With these functions, all representations are equivalent; i.e. for the
 * following problems you can always pick freely the most convenient form.
 * This problem is not particularly difficult, but it's a lot of work to
 * deal with all the special cases. *)

(* Path from one node to another one. Write a function paths g a b that returns
 * all acyclic path p from node a to node b ≠ a in the graph g.
 *
let paths g a b =
   *)









(* Cycle from a given node.
 * Write a functions cycle g a that returns a closed path (cycle) p starting at a
 * given node a in the graph g.
 *)

(* Construct all spanning trees.
 * Write a function s_tree g to construct all spanning trees of a given graph g.
 * With this predicate, find out how many spanning trees there are for the graph
 * depicted to the left.
 *)

(* Construct the minimal spanning tree.  *)

(* Graph isomorphism.
 * Two graphs G1(N1,E1) and G2(N2,E2) are isomorphic if there is a bijection f:
 * N1 → N2 such that for any nodes X,Y of N1, X and Y are adjacent if and only if
 * f(X) and f(Y) are adjacent.
 *)

(* Write a function that determines whether two graphs are isomorphic. *)

(* Node degree and graph coloration.
 * Write a function degree graph node that determines the degree of a given node.
 * Write a function that generates a list of all nodes of a graph sorted according
 * to decreasing degree.
 *)

(* Depth-first order graph traversal.
 * Write a function that generates a depth-first order graph traversal sequence.
 * The starting point should be specified, and the output should be a list of
 * nodes that are reachable from this starting point (in depth-first order).
 *)

(* Write a predicate that splits a graph into its connected components. *)

(* Write a predicate that finds out whether a given graph is bipartite.*)

(* Generate K-regular simple graphs with N nodes.
 * In a K-regular graph all nodes have a degree of K; i.e. the number of edges
 * incident in each node is K. How many (non-isomorphic!) 3-regular graphs with 6
 * nodes are there?
 *)
