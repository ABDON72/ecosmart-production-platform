output "alb_dns_name" {
  value       = aws_lb.ecosmart_alb.dns_name
  description = "DNS name of the load balancer"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.ecosmart_repo.repository_url
  description = "URL of the ECR repository"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.ecosmart_cluster.name
  description = "Name of the ECS cluster"
}

output "ecs_service_name" {
  value       = aws_ecs_service.ecosmart_service.name
  description = "Name of the ECS service"
}
