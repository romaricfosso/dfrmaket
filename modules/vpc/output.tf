output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}
output "vpc_id" {
  description = "ID du VPC"
  value       = module.vpc.vpc_id # remplace `main` par le nom réel de ta ressource VPC
}
output "public_subnets" {
  description = "Liste des subnets publics"
  value       = module.vpc.public_subnets
}
