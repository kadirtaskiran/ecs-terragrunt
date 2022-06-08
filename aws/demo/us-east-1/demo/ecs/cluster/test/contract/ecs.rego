package main

deny[msg] {
    ecs := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecs_cluster"]
    not ecs[0].values.name = "counter-app-cluster"
    msg = sprintf("ECS has wrong name: `%v`", [ecs[0].values.name])
}

deny[msg] {
    ecs := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecs_cluster"]
    not ecs[0].values.tags.Environment = "demo"
    msg = sprintf("ECS has wrong Environment tag: `%v`", [ecs[0].values.tags.Environment])
}

deny[msg] {
    ecs := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_ecs_cluster"]
    not ecs[0].values.tags.Owner = "kadir.taskiran"
    msg = sprintf("ECS has wrong Owner tag: `%v`", [ecs[0].values.tags.Owner])
}

