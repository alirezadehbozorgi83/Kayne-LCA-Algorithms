lass Entity

class Object

class Property

class Relation(val subject: Entity, val obj: Object, val properties: List[Property])

class Correspondence(val mapping: List[List[Double]], val properties: List[Property])

class LinearCorrespondence(val correspondence: Correspondence) {
  def isLinear(prop1: Property, prop2: Property, rel1: Relation, rel2: Relation): Boolean = {
    for (r1 <- rel1.properties) {
      for (r2 <- rel2.properties) {
        if (rel1.subject eq rel2.subject) && (rel1.obj ne rel2.obj) {
          val prop1_ij = correspondence.mapping(properties.indexOf(prop1))(rel1.properties.indexOf(r1))
          val prop1_jk = correspondence.mapping(properties.indexOf(prop1))(rel2.properties.indexOf(r2))
          val prop2_ij = correspondence.mapping(properties.indexOf(prop2))(rel1.properties.indexOf(r1))
          val prop2_jk = correspondence.mapping(properties.indexOf(prop2))(rel2.properties.indexOf(r2))
          if (prop1_ij != prop1_jk || prop2_ij != prop2_jk) {
            return false
          }
        }
      }
    }
    true
  }
}

//Example usage
val john = new Entity
val mary = new Entity
val book = new Object

val color = new Property
val size = new Property

val on1 = new Relation(john, book, List(color, size))
val on2 = new Relation(mary, book, List(color, size))

val color_size_corr = new Correspondence(List(List(0.0, 0.8), List(0.2, 0.0)), List(color, size))
val size_color_corr = new Correspondence(List(List(0.0, 0.6), List(0.4, 0.0)), List(size, color))
val color_size_lin_corr = new LinearCorrespondence(color_size_corr)

color_size_lin_corr.isLinear(color, size, on1, on2) // returns true

size_color_lin_corr.isLinear(color, size, on1, on2) // returns false