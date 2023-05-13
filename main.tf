provider "aws" {
  # Configuration options
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.user_one.name,
    aws_iam_user.user_two.name,
	aws_iam_user.user_threename,
    aws_iam_user.user_four.name,
    aws_iam_user.user_five.name,
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "devops"
}

resource "aws_iam_user" "user_one" {
  name = "tony"
}

resource "aws_iam_user" "user_two" {
  name = "thor"
}

resource "aws_iam_user" "user_three" {
  name = "steve"
}

resource "aws_iam_user" "user_four" {
  name = "natasha"
}

resource "aws_iam_user" "user_five" {
  name = "bruce"
}
