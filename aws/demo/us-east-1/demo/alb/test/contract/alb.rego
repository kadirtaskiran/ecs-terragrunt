package main

deny[msg] {
    alb := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_lb"]
    not alb[0].values.name = "counter-app-alb"
    msg = sprintf("ALB has wrong name: `%v`", [alb[0].values.name])
}

deny[msg] {
    alb := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_lb"]
    not alb[0].values.load_balancer_type = "application"
    msg = sprintf("ALB has wrong load_balancer_type: `%v`", [alb[0].values.load_balancer_type])
}
