resource "spacelift_stack" "first_stack" {
  branch     = "main"
  name       = "first stack"
  repository = "first_stack"
}


resource "spacelift_stack" "second_stack" {
  branch     = "main"
  name       = "second stack"
  repository = "second_stack"
}

resource "spacelift_stack_dependency" "test" {
  stack_id            = spacelift_stack.second_stack.id
  depends_on_stack_id = spacelift_stack.first_stack.id
}

resource "spacelift_stack_dependency_reference" "test" {
  stack_dependency_id = spacelift_stack_dependency.test.id
  output_name         = "second_stack_output"
  input_name          = "TF_VAR_second_stack_output"
}

resource "spacelift_stack_dependency" "test2" {
  stack_id            = spacelift_stack.first_stack.id
  depends_on_stack_id = spacelift_stack.second_stack.id
}

resource "spacelift_stack_dependency_reference" "test2" {
  stack_dependency_id = spacelift_stack_dependency.test.id
  output_name         = "first_stack_output"
  input_name          = "TF_VAR_first_stack_output"
}

terraform {
  required_providers {
    spacelift = {
      source  = "spacelift.io/spacelift-io/spacelift"
      version = "1.13.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

provider "spacelift" {}

provider "aws" {
}
