# Define entities
entity = Dict()

# Define objects
object = Dict()

# Define properties
property = Dict()

# Define relations
relation = Dict()

# Define correspondences
correspondence = Dict()

# Define linear correspondences
function linear_correspondence(prop1, prop2, rel1, rel2, corr)
    is_linear = true
    for i in 1:length(rel1)
        for j in 1:length(rel2)
            if rel1[i]["subject"] == rel2[j]["subject"] && rel1[i]["object"] != rel2[j]["object"]
                prop1_ij = corr[prop1][rel1[i]["object"], rel1[i]["subject"]]
                prop1_jk = corr[prop1][rel2[j]["object"], rel2[j]["subject"]]
                prop2_ij = corr[prop2][rel1[i]["object"], rel1[i]["subject"]]
                prop2_jk = corr[prop2][rel2[j]["object"], rel2[j]["subject"]]
                if !(prop1_ij == prop1_jk && prop2_ij == prop2_jk)
                    is_linear = false
                    return is_linear
                end
            end
        end
    end
    is_linear
end

# Test linear correspondence
entity["john"] = Dict()
entity["mary"] = Dict()
object["book"] =Dict()

# Define properties
property["color"] = Dict()
property["size"] = Dict()

# Define relations
relation["on"] = []

# Define correspondences
correspondence["color_size"] = [0.2 0.8; 0.6 0.4]
correspondence["size_color"] = inv(correspondence["color_size"])

# Set up example relation
push!(relation["on"], Dict("subject" => entity["john"], "object" => object["book"], "properties" => [property["color"], property["size"]]))
push!(relation["on"], Dict("subject" => entity["mary"], "object" => object["book"], "properties" => [property["color"], property["size"]]))

# Check if on relation satisfies the LCA
is_linear = linear_correspondence("color_size", "size_color", relation["on"][1:1], relation["on"][2:2], correspondence)
if is_linear
    println("The on relation satisfies the Linear Correspondence Axiom.")
else
    println("The on relation does not satisfy the Linear Correspondence Axiom.")
end