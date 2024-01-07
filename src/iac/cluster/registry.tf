
data "aws_ecr_repository" "local_repo" {
  name = "local-ecs-repo"
}

resource "aws_ecr_repository" "app_ecr" {
  name                 =  data.aws_ecr_repository.local_repo.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "local_repo_lifecycle" {
  repository = data.aws_ecr_repository.local_repo.name

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep last 30 images",
                "selection": {
                    "tagStatus": "tagged",
                    "tagPrefixList": ["v"],
                    "countType": "imageCountMoreThan",
                    "countNumber": 30
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}