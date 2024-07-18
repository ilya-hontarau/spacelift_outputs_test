resource "spacelift_stack_dependency" "this" {
  stack_id            = spacelift_stack.first_stack.id
  depends_on_stack_id = spacelift_stack.second_stack.id
}

resource "spacelift_stack_dependency_reference" "this" {
  stack_dependency_id = spacelift_stack_dependency.this.id
  output_name         = "first_stack_output"
  input_name          = "TF_VAR_first_stack_output"
}

resource "spacelift_stack_dependency" "that" {
  stack_id            = spacelift_stack.first_stack.id
  depends_on_stack_id = spacelift_stack.third_stack.id
}

resource "spacelift_stack_dependency_reference" "that" {
  stack_dependency_id = spacelift_stack_dependency.that.id
  output_name         = "second_stack_output"
  input_name          = "TF_VAR_second_stack_output"
}


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

resource "spacelift_stack" "third_stack" {
  branch     = "main"
  name       = "third stack"
  repository = "third_stack"
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
