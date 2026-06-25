locals {

    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg
    redis_sg_id = data.aws_ssm_parameter.redis_sg
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg
    user_sg_id = data.aws_ssm_parameter.user_sg
    cart_sg_id = data.aws_ssm_parameter.cart_sg
    shipping_sg_id = data.aws_ssm_parameter.shipping_sg
    payment_sg_id = data.aws_ssm_parameter.payment_sg
    backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg
    frontend_sg_id = data.aws_ssm_parameter.frontend_sg
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg
    bastion_sg_id = data.aws_ssm_parameter.Baston_sg


}