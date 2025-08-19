# ALB Security Group: allow inbound HTTP from anywhere
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP inbound traffic from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "alb-sg" }
}

# ECS Task Security Group: allow inbound from ALB only
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow inbound from ALB security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow traffic from ALB"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ecs-sg" }
}
