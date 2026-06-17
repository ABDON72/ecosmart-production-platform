resource "aws_ecr_repository" "ecosmart_repo" {
  name                 = "ecosmart-production"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ecosmart-production-ecr"
  }
}
