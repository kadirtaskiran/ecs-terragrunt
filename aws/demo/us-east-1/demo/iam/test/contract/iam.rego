package main

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_instance_profile"]
    not iam[0].values.name = "counter-app-demo_ecs_instance_profile"
    msg = sprintf("IAM instance profile has wrong name: `%v`", [iam[0].values.name])
}

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_instance_profile"]
    not iam[0].values.tags.Owner = "kadir.taskiran"
    msg = sprintf("IAM instance profile has no Owner tag with expected value: `%v`", [iam[0].values.tags.Owner])
}

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_instance_profile"]
    not iam[0].values.tags.Environment = "demo"
    msg = sprintf("IAM instance profile has no Environment tag with expected value `%v`", [iam[0].values.tags.Environment])
}

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_role"]
    not iam[0].values.name = "counter-app-demo_ecs_instance_role"
    msg = sprintf("IAM role has wrong name: `%v`", [iam[0].values.name])
}

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_role"]
    not iam[0].values.tags.Owner = "kadir.taskiran"
    msg = sprintf("IAM role has no Owner tag with expected value: `%v`", [iam[0].values.tags.Owner])
}

deny[msg] {
    iam := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_iam_role"]
    not iam[0].values.tags.Environment = "demo"
    msg = sprintf("IAM role has no Environment tag with expected value `%v`", [iam[0].values.tags.Environment])
}

