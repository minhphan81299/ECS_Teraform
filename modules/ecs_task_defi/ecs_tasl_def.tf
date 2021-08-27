resource "aws_ecs_task_definition" "task_defi" {
  family = "${var.NAME}-${var.ENV}"
  container_definitions = jsonencode([{
    name             = "${var.NAME}-${var.ENV}"
    image            = "${var.IMAGE_ID}"
    essential        = "${var.IS_ESSENTIAL}"
    entrypoint       = "${var.ENTRYPOINT}"
    workingDirectory = "${var.WORKDIR}"
    logConfiguration = {
      "logDriver" : "awslogs",
      "options" : {
        "awslogs-group" : "awslogs-quick-app-dev",
        "awslogs-region" : "ap-southeast-1",
        "awslogs-stream-prefix" : "quick-app-dev"
      }
    }
    environment = [
      {
        "name"  = "ASPNETCORE_URLS"
        "value" = "https://+:81;http://+:80"

      },
      {
        "name"  = "ASPNETCORE_Environment"
        "value" = "${var.ENV}"
      }
    ]
    portMappings = [{
      containerPort = "80"
      hostPort      = "80"
      }
      #,   {
      #     containerPort = "${var.HTTPS_PORT}"
      #     hostPort      = "${var.HTTPS_PORT}"
      #   }
    ]
  }])

  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  execution_role_arn       = var.IAM_ROLE_ID
}

