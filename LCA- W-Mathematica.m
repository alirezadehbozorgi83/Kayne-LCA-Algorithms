(* Define entities *)
entity = <||>;

(* Define objects *)
object = <||>;

(* Define properties *)
property = <||>;

(* Define relations *)
relation = <||>;

(* Define correspondences *)
correspondence = <||>;

(* Define linear correspondences *)
linearCorrespondence[prop1_, prop2_, rel1_, rel2_, corr_] := 
 Module[{isLinear = True},
  Do[
   Do[
    If[rel1[[i]]["subject"] == rel2[[j]]["subject"] && 
      rel1[[i]]["object"] != rel2[[j]]["object"], 
     prop1ij = corr[prop1][[rel1[[i]]["object"], rel1[[i]]["subject"]]];
     prop1jk = corr[prop1][[rel2[[j]]["object"], rel2[[j]]["subject"]]];
     prop2ij = corr[prop2][[rel1[[i]]["object"], rel1[[i]]["subject"]]];
     prop2jk = corr[prop2][[rel2[[j]]["object"], rel2[[j]]["subject"]]];
     If[!(prop1ij == prop1jk && prop2ij == prop2jk), 
      isLinear = False; Return[isLinear]]
     ]
   ],
   {i, Length[rel1]}, {j, Length[rel2]}
   ];
  isLinear
 ]

(* Test linear correspondence *)
entity["john"] = <||>;
entity["mary"] = <||>;
object["book"] = <||>;
property["color"] = <||>;
property["size"] = <||>;
relation["on"] = {};
correspondence["colorSize"] = RandomReal[1, {2, 2}];
correspondence["sizeColor"] = Inverse[correspondence["colorSize"]];
AppendTo[relation["on"], 
 Association[
  "subject" -> entity["john"], 
  "object" -> object["book"], 
  "properties" -> {property["color"], property["size"]}
 ]]
AppendTo[relation["on"], 
 Association[
  "subject" -> entity["mary"], 
  "object" -> object["book"], 
  "properties" -> {property["color"], property["size"]}
 ]]

(* Check if on relation satisfies the LCA *)
isLinear = linearCorrespondence["colorSize", "sizeColor", relation["on"][[1 ;; 1]], relation["on"][[2 ;; 2]], correspondence];
If[isLinear, 
 Print["The on relation satisfies the Linear Correspondence Axiom."], 
 Print["The on relation does not satisfy the Linear Correspondence Axiom."]
]