# Define entities
entity <- list()

# Define objects
object <- list()

# Define properties
property <- list()

# Define relations
relation <- list()

# Define correspondences
correspondence <- list()

# Define linear correspondences
linear_correspondence <- function(prop1, prop2, rel1, rel2, corr) {
  is_linear <- TRUE
  for (i in seq_along(rel1)) {
    for (j in seq_along(rel2)) {
      if (identical(rel1[[i]]$subject, rel2[[j]]$subject) && rel1[[i]]$object != rel2[[j]]$object) {
        prop1_ij <- corr[[prop1]][[rel1[[i]]$object, rel1[[i]]$subject]]
        prop1_jk <- corr[[prop1]][[rel2[[j]]$object, rel2[[j]]$subject]]
        prop2_ij <- corr[[prop2]][[rel1[[i]]$object, rel1[[i]]$subject]]
        prop2_jk <- corr[[prop2]][[rel2[[j]]$object, rel2[[j]]$subject]]
        if (!(prop1_ij == prop1_jk && prop2_ij== prop2_jk)) {
          is_linear <- FALSE
          return(is_linear)
        }
      }
    }
  }
  is_linear
}

# Test linear correspondence
entity$john <- list()
entity$mary <- list()
object$book <- list()
property$color <- list()
property$size <- list()
relation$on <- list()
correspondence$color_size <- matrix(c(0.2, 0.8, 0.6, 0.4), nrow = 2, ncol = 2, byrow = TRUE)
correspondence$size_color <- solve(correspondence$color_size)
relation$on[[1]] <- list(subject = entity$john, object = object$book, properties = list(property$color, property$size))
relation$on[[2]] <- list(subject = entity$mary, object = object$book, properties = list(property$color, property$size))

# Check if on relation satisfies the LCA
is_linear <- linear_correspondence("color_size", "size_color", relation$on[1:1], relation$on[2:2], correspondence)
if (is_linear) {
  print("The on relation satisfies the Linear Correspondence Axiom.")
} else {
  print("The on relation does not satisfy the Linear Correspondence Axiom.")
}