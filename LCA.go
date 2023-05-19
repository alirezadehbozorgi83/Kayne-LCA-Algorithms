package main

import (
	"fmt"
)

// Define entities
type Entity struct{}

// Define objects
type Object struct{}

// Define properties
type Property struct{}

// Define relations
type Relation struct {
	subject Entity
	object  Object
	props   []Property
}

// Define correspondences
type Correspondence struct {
	mapping map[Property]map[Entity]float64
}

// Define linear correspondences
type LinearCorrespondence struct {
	Correspondence
}

// Define function to check if a pair of relations satisfy the Linear Correspondence Axiom
func isLinearCorrespondence(prop1 Property, prop2 Property, rel1 Relation, rel2 Relation, corr Correspondence) bool {
	isLinear := true
	for _, r1 := range rel1.props {
		for _, r2 := range rel2.props {
			if rel1.subject == rel2.subject && rel1.object != rel2.object {
				prop1_ij := corr.mapping[prop1][r1]
				prop1_jk := corr.mapping[prop1][r2]
				prop2_ij := corr.mapping[prop2][r1]
				prop2_jk := corr.mapping[prop2][r2]
				if !(prop1_ij == prop1_jk && prop2_ij == prop2_jk) {
					isLinear = false
					return isLinear
				}
			}
		}
	}
	return isLinear
}

func main() {
	// Define example entities
	john := Entity{}
	mary := Entity{}
	book := Object{}

	// Define example properties
	color := Property{}
	size := Property{}

	// Define example relations
	on1 := Relation{subject: john, object: book, props: []Property{color, size}}
	on2 := Relation{subject: mary, object: book, props: []Property{color, size}}

	// Define example correspondences
	colorSizeCorr := Correspondence{
		mapping: map[Property]map[Entity]float64{
			color: map[Entity]float64{
				size: 0.8,
			},
			size: map[Entity]float64{
				color: 0.2,
			},
		},
	}
	sizeColorCorr := Correspondence{
		mapping: map[Property]map[Entity]float64{
			color: map[Entity]float64{
				size: 0.6,
			},
			size: map[Entity]float64{
				color: 0.4,
			},
		},
	}
	colorSizeLinCorr := LinearCorrespondence{colorSizeCorr}
	sizeColorLinCorr := LinearCorrespondence{sizeColorCorr}

	// Check if on1 and on2 satisfy the Linear CorrespondenceAxiom
	if isLinearCorrespondence(color, size, on1, on2, colorSizeLinCorr) && isLinearCorrespondence(size, color, on1, on2, sizeColorLinCorr) {
		fmt.Println("The Linear Correspondence Axiom is satisfied.")
	} else {
		fmt.Println("The Linear Correspondence Axiom is not satisfied.")
	}
}
