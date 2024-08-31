output "ecs_service_sg_id" {
  value = module.ecs_service_sg.id
}

output "ecs_alb_sg_id" {
  value = module.sg_alb.id
}
