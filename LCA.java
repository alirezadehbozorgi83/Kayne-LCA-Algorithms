class Entity {}

class Object extends Entity {}

class Property extends Entity {}

class Relation extends Entity {
    Object subject;
    Object object;
}

class Correspondence extends Entity {
    Property property1;
    Property property2;
}

class LinearCorrespondence extends Correspondence {
    boolean isLinearCorrespondence(Relation relation1, Relation relation2) {
        for (int i = 0; i < relation1.subject; i++) {
            for (int j = 0; j < relation1.object; j++) {
                for (int k = 0; k < relation2.object; k++) {
                    if (relation1[i][j] && relation2[j][k]) {
                        if (!(property1[i][j] == property1[j][k] && property2[i][j] == property2[j][k])) {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }
}

public class Main {
    public static void main(String[] args)