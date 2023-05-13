provider "aws" {
  # Configuration options
}

resource "aws_iam_user" "user1" {
  name = "Tony"

  tags = {
    tag-key = "Devops"
  }
}