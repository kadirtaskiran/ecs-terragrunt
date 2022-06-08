package main

deny[msg] {
    vpc := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_vpc"]
    not vpc[0].values.cidr_block = "10.10.0.0/16"
    msg = sprintf("VPC has wrong CIDR: `%v`", [vpc[0].values.cidr_block])
}

deny[msg] {
    vpc := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_vpc"]
    not vpc[0].values.tags.Name = "kmt-demo"
    msg = sprintf("VPC name is wrong: `%v`", [vpc[0].values.tags.Name])
}

deny[msg] {
    vpc := input.variables
    not vpc.azs.value = ["us-east-1a", "us-east-1b", "us-east-1c"]
    msg = sprintf("VPC availability zones are wrong: `%v`", [vpc.azs])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.private[0]"]
    not subnet[0].values.cidr_block = "10.10.11.0/24"
    msg = sprintf("Private subnet 0 CIDRs is wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.private[1]"]
    not subnet[0].values.cidr_block = "10.10.12.0/24"
    msg = sprintf("Private subnet 1 CIDRs' are wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.private[2]"]
    not subnet[0].values.cidr_block = "10.10.13.0/24"
    msg = sprintf("Private subnet 2 CIDRs' are wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.public[0]"]
    not subnet[0].values.cidr_block = "10.10.1.0/24"
    msg = sprintf("Public subnet 0 CIDRs is wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.public[1]"]
    not subnet[0].values.cidr_block = "10.10.2.0/24"
    msg = sprintf("Public subnet 1 CIDRs is wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    subnet := [r | r := input.planned_values.root_module.resources[_]; r.address == "aws_subnet.public[2]"]
    not subnet[0].values.cidr_block = "10.10.3.0/24"
    msg = sprintf("Public subnet 2 CIDRs is wrong : `%v`", [subnet[0].values.cidr_block])
}

deny[msg] {
    vpc := input.variables
    not vpc.enable_ipv6.value = "false"
    msg = sprintf("Enable ipv6 must be false : `%v`", [vpc.enable_ipv6])
}

deny[msg] {
    vpc := input.variables
    not vpc.enable_nat_gateway.value = "true"
    msg = sprintf("enable_nat_gateway must be true : `%v`", [vpc.enable_nat_gateway])
}

deny[msg] {
    vpc := input.variables
    not vpc.single_nat_gateway.value = "true"
    msg = sprintf("single_nat_gateway must be true : `%v`", [vpc.single_nat_gateway])
}

deny[msg] {
    vpc := input.variables
    not vpc.enable_dns_hostnames.value = "true"
    msg = sprintf("enable_dns_hostnames must be true : `%v`", [vpc.enable_dns_hostnames])
}

deny[msg] {
    vpc := input.variables
    not vpc.enable_dns_support.value = "true"
    msg = sprintf("enable_dns_support must be true : `%v`", [vpc.enable_dns_support])
}

deny[msg] {
    vpc := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_vpc"]
    not vpc[0].values.tags.Owner = "kadir.taskiran"
    msg = sprintf("VPC has no Owner tag with expected value: `%v`", [vpc[0].values.tags.Owner])
}

deny[msg] {
    vpc := [r | r := input.planned_values.root_module.resources[_]; r.type == "aws_vpc"]
    not vpc[0].values.tags.Environment = "demo"
    msg = sprintf("VPC has no Environment tag with expected value `%v`", [vpc[0].values.tags.Environment])
}

deny[msg] {
    inputs := input.variables
    not inputs.enable_vpn_gateway.value = "false"
    msg = sprintf("enable_vpn_gateway must be false : `%v`", [inputs.enable_vpn_gateway])
}
