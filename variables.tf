
variable "region" {
  default = "us-east-1"
  type    = string
}

variable "rule_name" {
  default = "rule_event_chatbot"
  type = string
  
}
variable "role_name" {
  type = string
  default = "iam_role_lambda"
  
}
variable "handler" {
  type = string
  default = "lambda_function.lambda_handler"
  
}

variable "default_tags" {
  type = map(string)

  default = {
    "Projeto"   = "INFRA AS A CODE - EventBridgeRules"
    "Empresa"   = "VPAULO.COM"
    "Create by" = "Terraform Cloud"
    "Contato"   = "contato@vpaulo.com"
  }

}

