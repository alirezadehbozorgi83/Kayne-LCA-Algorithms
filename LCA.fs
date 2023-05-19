class entity {
  isa entity
}

class object {
  isa entity
}

class property {
  isa entity
}

class relation {
  isa entity
  inverse relation
  plays subject, object
}

class correspondence {
  isa entity
  plays property1, property2
}

class linear_correspondence {
  isa correspondence
  property1: property
  property2: property
  axioms {
    forall x, y, z: object |
      relation(x, y) and relation(y, z) implies 
        correspondence(property1(x, y), property2(y, z))
  }
}