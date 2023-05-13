provider "aws" {
  # Configuration options
}

resource "aws_iam_user" "users5" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )
  }
}