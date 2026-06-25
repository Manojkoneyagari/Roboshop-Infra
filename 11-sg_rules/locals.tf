locals {

    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg.value
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg.value
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg.value
    user_sg_id = data.aws_ssm_parameter.user_sg.value
    cart_sg_id = data.aws_ssm_parameter.cart_sg.value
    shipping_sg_id = data.aws_ssm_parameter.shipping_sg.value
    payment_sg_id = data.aws_ssm_parameter.payment_sg.value
    backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg.value
    frontend_sg_id = data.aws_ssm_parameter.frontend_sg.value
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg.value
    bastion_sg_id = data.aws_ssm_parameter.Bastion_sg.value


}