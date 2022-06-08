package main

deny[msg] {
    asg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_autoscaling_group"]
    not asg[0].values.name_prefix = "counter-app-asg-"
    msg = sprintf("ASG has wrong name prefix: `%v`", [asg[0].values.name_prefix])
}

deny[msg] {
    asg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_autoscaling_group"]
    not asg[0].values.max_size = 2
    msg = sprintf("ASG  has wrong max_size: `%v`", [asg[0].values.max_size])
}




