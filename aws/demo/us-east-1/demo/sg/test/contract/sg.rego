package main

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_security_group"]
    not sg[0].values.tags.Name = "alb-sg-kmt-demo"
    msg = sprintf("Sg has wrong Name Tag: `%v`", [sg[0].values.tags.Name])
}

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_security_group"]
    not sg[0].values.vpc_id = "vpc-02212b227cf5a3d67"
    msg = sprintf("Sg has wrong VPC id: `%v`", [sg[0].values.vpc_id])
}

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_security_group_rule.ingress_rules[0]"]
    not sg[0].values.from_port = 80
    msg = sprintf("Sg has wrong from_port: `%v`", [sg[0].values.from_port])
}

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_security_group_rule.ingress_rules[0]"]
    not sg[0].values.to_port = 80
    msg = sprintf("Sg has wrong to_port: `%v`", [sg[0].values.to_port])
}

