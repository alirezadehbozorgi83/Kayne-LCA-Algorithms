#include <stdio.h>

typedef struct Entity Entity;
typedef struct Object Object;
typedef struct Property Property;
typedef struct Relation Relation;
typedef struct Correspondence Correspondence;
typedef struct LinearCorrespondence LinearCorrespondence;

struct Entity {
    int type;
};

struct Object {
    Entity entity;
};

struct Property {
    Entity entity;
};

struct Relation {
    Entity entity;
    Object subject;
    Object object;
};

struct Correspondence {
    Entity entity;
    Property property1;
    Property property2;
};

struct LinearCorrespondence {
    Correspondence correspondence;
};

int is_linear_correspondence(LinearCorrespondence* lc, Relation* relation1, Relation* relation2) {
    for (int i = 0; i < relation1->subject; i++) {
        for (int j = 0; j < relation1->object; j++) {
            for (int k = 0; k < relation2->object; k++) {
                if (relation1(i, j) && relation2(j, k)) {
                    if (!(lc->correspondence.property1(i, j) == lc->correspondence.property1(j, k) && lc->correspondence.property2(i, j) == lc->correspondence.property2(j, k))) {
                    return 0;
                }
            }
        }
    }
    return 1;
}

int main() {
    Object john, mary, book, table;
    john.type = 1;
    mary.type = 1;
    book.type = 2;
    table.type = 2;

    Property owns, reads;
    owns.type = 3;
    reads.type = 3;

    Relation r1, r2;
    r1.subject = john;
    r1.object = book;
    r2.subject = book;
    r2.object = table;

    Correspondence c;
    c.property1 = owns;
    c.property2 = reads;

    LinearCorrespondence lc;
    lc.correspondence = c;

    if (is_linear_correspondence(&lc, &r1, &r2)) {
        printf("The linear correspondence axiom holds!\n");
    } else {
        printf("The linear correspondence axiom does not hold.\n");
    }

    return 0;
}