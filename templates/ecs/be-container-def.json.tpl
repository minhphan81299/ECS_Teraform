 [{
        "name": "be-quickapp-prod",
        "image": "${be_image}",
        "essential": true,
        "memoryReservation": 256,
        "environment": [
            {"name": "DB_ENDPOINT", "value": "${db_host}"},
            {"name": "DB_NAME", "value": "${db_name}"},
            {"name": "env", "value": "Production"},
            {"name": "DB_USER", "value": "${db_user}"},
            {"name": "DB_PWD", "value": "${db_pass}"},
            {"name": "ALLOWED_HOSTS", "value": "${allowed_hosts}"}
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "server"
            }
        },
        "portMappings": [
            {
                "containerPort": 8088,
                "hostPort": 8088
            }
        ],
        "mountPoints": [
            {
                "readOnly": false,
                "containerPath": "/vol/be",
                "sourceVolume": "static"
            }
        ]
    }
 ]