% Define entities
entity = struct();

% Define objects
object = struct();

% Define properties
property = struct();

% Define relations
relation = struct();

% Define correspondences
correspondence = struct();

% Define linear correspondences
function is_linear = linear_correspondence(prop1, prop2, rel1, rel2, corr)
    is_linear = true;
    for i = 1:numel(rel1)
        for j = 1:numel(rel2)
            if rel1(i).subject == rel2(j).subject && rel1(i).object ~= rel2(j).object
                prop1_ij = corr.(prop1)(rel1(i).object, rel1(i).subject);
                prop1_jk = corr.(prop1)(rel2(j).object, rel2(j).subject);
                prop2_ij = corr.(prop2)(rel1(i).object, rel1(i).subject);
                prop2_jk = corr.(prop2)(rel2(j).object, rel2(j).subject);
                if ~(prop1_ij == prop1_jk && prop2_ij == prop2_jk)
                    is_linear = false;
                    return
                end
            end
        end
    end
end

% Test linear correspondence
entity.john = object();
entity.mary = object();
object.book =struct();
property.color = struct();
property.size = struct();
relation.on = struct();
correspondence.color_size = rand(2);
correspondence.size_color = inv(correspondence.color_size);
relation.on(1).subject = entity.john;
relation.on(1).object = object.book;
relation.on(2).subject = entity.mary;
relation.on(2).object = object.book;
relation.on(1).properties = [property.color, property.size];
relation.on(2).properties = [property.color, property.size];

% Check if on relation satisfies the LCA
is_linear = linear_correspondence('color_size', 'size_color', relation.on(1:1), relation.on(2:2), correspondence);
if is_linear
    disp('The on relation satisfies the Linear Correspondence Axiom.');
else
    disp('The on relation does not satisfy the Linear Correspondence Axiom.');
end