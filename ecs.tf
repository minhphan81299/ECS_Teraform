resource "aws_ecs_cluster" "quickapp" {
  name = "Quick-App-Cluster"


}

resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "ecs-api"

}



data "template_file" "web_container_definitions" {
  template = file("templates/ecs/container-definitions.json.tpl")

  vars = {
    app_image        = "578271985279.dkr.ecr.ap-southeast-1.amazonaws.com/quickapplication:fev2"
    db_host          = aws_db_instance.database.address
    db_name          = "quickAppdata"
    db_user          = "sa"
    db_pass          = "Your_password123"
    log_group_name   = aws_cloudwatch_log_group.ecs_task_logs.name
    log_group_region = "ap-southeast-1"
    allowed_hosts    = "*"
  }
}

data "template_file" "api_container_definitions" {
  template = file("templates/ecs/be-container-def.json.tpl")

  vars = {
    be_image         = "578271985279.dkr.ecr.ap-southeast-1.amazonaws.com/quickapplication:bev1"
    db_host          = aws_db_instance.database.address
    db_name          = "quickAppdata"
    db_user          = "sa"
    db_pass          = "Your_password123"
    log_group_name   = aws_cloudwatch_log_group.ecs_task_logs.name
    log_group_region = "ap-southeast-1"
    allowed_hosts    = "*"
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "quickappfe-api"
  container_definitions    = data.template_file.web_container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.app_iam_role.arn
  volume {
    name = "static"
  }


}

resource "aws_ecs_task_definition" "server" {
  family                   = "quickappbe-server"
  container_definitions    = data.template_file.api_container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.app_iam_role.arn
  volume {
    name = "static"
  }


}



resource "aws_ecs_service" "api" {
  name            = "quickapp-web"
  cluster         = aws_ecs_cluster.quickapp.name
  task_definition = aws_ecs_task_definition.api.family
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private-subnet-1.id,
      aws_subnet.private-subnet-1b.id,
    ]
    security_groups = [aws_security_group.allow_web.id]

  }
  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "quickapp-prod"
    container_port   = 80
  }



}

resource "aws_ecs_service" "server" {
  name            = "quickapp-server"
  cluster         = aws_ecs_cluster.quickapp.name
  task_definition = aws_ecs_task_definition.server.family
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private-subnet-be1.id,
      aws_subnet.private-subnet-be1b.id,
    ]
    security_groups = [aws_security_group.allow_web.id]

  }
  load_balancer {
    target_group_arn = aws_lb_target_group.server.arn
    container_name   = "be-quickapp-prod"
    container_port   = 8088
  }



}

output "api_end_point" {
  value = aws_lb.api.dns_name
}

