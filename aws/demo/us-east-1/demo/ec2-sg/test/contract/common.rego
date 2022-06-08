package main

deny[msg] { 
    not input.terraform_version = "0.15.0"
    msg = sprintf("Terraform version must be 0.15.0: `%v`", [input.terraform_version])
}