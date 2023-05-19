class Entity:
    pass

class Object(Entity):
    pass

class Property(Entity):
    pass

class Relation(Entity):
    def __init__(self, subject, object):
        self.subject = subject
        self.object = object

class Correspondence(Entity):
    def __init__(self, property1, property2):
        self.property1 = property1
        self.property2 = property2

class LinearCorrespondence(Correspondence):
    def __init__(self, property1, property2):
        super().__init__(property1, property2)

    def is_linear_correspondence(self, relation1, relation2):
        for x in relation1.subject:
            for y in relation1.object:
                for z in relation2.object:
                    if relation1(x, y) and relation2(y, z):
                        if not (self.property1(x, y) == self.property1(y, z) and self.property2(x, y) == self.property2(y, z)):
                            return False
        return True