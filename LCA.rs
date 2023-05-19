struct Entity {}
struct Object {}
struct Property {}
struct Relation<'a> {
    subject: &'a Entity,
    object: &'a Object,
    properties: Vec<&'a Property>,
}

struct Correspondence<'a> {
    mapping: Vec<Vec<f64>>,
    properties: Vec<&'a Property>,
}

struct LinearCorrespondence<'a> {
    correspondence: &'a Correspondence<'a>,
}

impl<'a> LinearCorrespondence<'a> {
    fn is_linear(&self, prop1: &'a Property, prop2: &'a Property, rel1: &'a Relation<'a>, rel2: &'a Relation<'a>) -> bool {
        for r1 in rel1.properties.iter() {
            for r2 in rel2.properties.iter() {
                if (rel1.subject as *const Entity) == (rel2.subject as *const Entity) && (rel1.object as *const Object) != (rel2.object as *const Object)