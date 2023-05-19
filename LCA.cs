using System;

class Entity { }

class Object : Entity { }

class Property : Entity { }

class Relation : Entity
{
    public Object Subject { get; set; }
    public Object Object { get; set; }
}

class Correspondence : Entity
{
    public Property Property1 { get; set; }
    public Property Property2 { get; set; }
}

class LinearCorrespondence : Correspondence
{
    public bool IsLinearCorrespondence(Relation relation1, Relation relation2)
    {
        for (int i = 0; i < relation1.Subject; i++)
        {
            for (int j = 0; j < relation1.Object; j++)
            {
                for (int k = 0; k < relation2.Object; k++)
                {
                    if (relation1[i, j] && relation2[j, k])
                    {
                        if (!(Property1[i, j] == Property1[j, k] && Property2[i, j] == Property2[j, k]))
                        {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }
}

class Program
{
    static void Main(string[] args)
    {
        Object john = new Object();
        Object mary = new Object();
       Object book = new Object();
        Object table = new Object();

        Property owns = new Property();
        Property reads = new Property();

        Relation r1 = new Relation { Subject = john, Object = book };
        Relation r2 = new Relation { Subject = book, Object = table };

        Correspondence c = new Correspondence { Property1 = owns, Property2 = reads };

        LinearCorrespondence lc = new LinearCorrespondence { Property1 = owns, Property2 = reads };

        if (lc.IsLinearCorrespondence(r1, r2))
        {
            Console.WriteLine("The linear correspondence axiom holds!");
        }
        else
        {
            Console.WriteLine("The linear correspondence axiom does not hold.");
        }
    }
}