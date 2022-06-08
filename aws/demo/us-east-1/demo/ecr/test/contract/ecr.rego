package main

deny[msg] {
    ecr := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecr_repository"]
    not ecr[0].values.name = "counter-app"
    msg = sprintf("Ecr has wrong Name: `%v`", [ecr[0].values.name])
}

deny[msg] {
    ecr := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecr_repository"]
    not ecr[0].values.tags.Owner = "kadir.taskiran"
    msg = sprintf("Ecr has wrong Owner Tag: `%v`", [ecr[0].values.tags.Owner])
}


deny[msg] {
    ecr := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecr_repository"]
    not ecr[0].values.tags.Environment = "demo"
    msg = sprintf("Ecr has wrong Environment Tag: `%v`", [ecr[0].values.tags.Environment])
}

deny[msg] {
    ecr := input.variables
    not ecr.repository_type.value = "private"
    msg = sprintf("Repository type must be private : `%v`", [ecr.repository_type])
}
