class Entity {}

class Object extends Entity {}

class Property extends Entity {}

class Relation extends Entity {
  constructor(subject, object) {
    this.subject = subject
    this.object = object
  }
}

class Correspondence extends Entity {
  constructor(property1, property2) {
    this.property1 = property1
    this.property2 = property2
  }
}

class LinearCorrespondence extends Correspondence {
  isLinearCorrespondence(relation1, relation2) {
    for (let i = 0; i < relation1.subject; i++) {
      for (let j = 0; j < relation1.object; j++) {
        for (let k = 0; k < relation2.object; k++) {
          if (relation1[i][j] && relation2[j][k]) {
            if (
              !(
                this.property1[i][j] == this.property1[j][k] &&
                this.property2[i][j] == this.property2[j][k]
              )
            ) {
              return false
            }
          }
        }
      }
    }
    return true
  }
}

const john = new Object()
const mary = new Object()
const book = new Object()
const table = new Object()

const owns = new Property()
constreads = new Property()

const r1 = new Relation(john, book)
const r2 = new Relation(book, table)

const c = new Correspondence(owns, reads)
const lc = new LinearCorrespondence(owns, reads)

if (lc.isLinearCorrespondence(r1, r2)) {
  console.log('The linear correspondence axiom holds!')
} else {
  console.log('The linear correspondence axiom does not hold.')
}