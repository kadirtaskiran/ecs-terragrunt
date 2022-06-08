package main

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_security_group"]
    not sg[0].values.tags.Name = "counter-app-ec2-sg"
    msg = sprintf("Sg has wrong Name Tag: `%v`", [sg[0].values.tags.Name])
}

deny[msg] {
    sg := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_security_group"]
    not sg[0].values.vpc_id = "vpc-02212b227cf5a3d67"
    msg = sprintf("Sg has wrong VPC id: `%v`", [sg[0].values.vpc_id])
}


