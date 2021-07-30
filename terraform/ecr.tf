resource "aws_ecr_repository" "nodejs" {
  name                 = "nodejs-ecr"
  image_tag_mutability = "MUTABLE"
}