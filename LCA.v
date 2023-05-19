// Define entities
module entity_node #(parameter num_properties = 0)(
input [num_properties-1:0] in_data,
output [num_properties-1:0] out_data
);
endmodule

// Define objects
module object_node #(
parameter num_properties = 0
)(
input [num_properties-1:0] in_data,
output [num_properties-1:0] out_data
);
endmodule

// Define properties
module property_node #(
parameter num_entities = 0
)(
input [num_entities-1:0] in_data,
output [num_entities-1:0] out_data
);
endmodule

// Define relations
module relation_node #(
parameter num_subjects = 0,
parameter num_objects = 0
)(
input [num_subjects-1:0] subject,
input [num_objects-1:0] object,
input [num_subjectsnum_objects-1:0] in_data,
output [num_subjectsnum_objects-1:0] out_data
);
assign out_data = in_data; // identity function
endmodule

// Define correspondences
module correspondence_node #(
parameter num_properties = 0
)(
input [num_propertiesnum_properties-1:0] in_data,
output[num_propertiesnum_properties-1:0] out_data
);
endmodule

// Define linear correspondences
module linear_correspondence_node #(
parameter num_properties = 0,
parameter num_subjects = 0,
parameter num_objects = 0
)(
input [num_subjects-1:0] subject1,
input [num_objects-1:0] object1,
input [num_subjects-1:0] subject2,
input [num_objects-1:0] object2,
input [num_propertiesnum_propertiesnum_subjectsnum_objects-1:0] properties,
output logic is_linear_correspondence
);
integer i, j, k;
logic [num_properties-1:0] prop1, prop2;
logic [num_propertiesnum_properties-1:0] prop_matrix1, prop_matrix2;