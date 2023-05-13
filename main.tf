provider "aws" {
  # Configuration options
}

resource "aws_iam_user" "userlist" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )
}