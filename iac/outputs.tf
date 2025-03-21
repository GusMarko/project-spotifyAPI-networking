output "vpc_id" {
    value = aws_vpc.main.id
}

output "priv_sub_id"  {
    value = aws_subnet.private.id
}

output "pub_sub_id" {
    value = aws_subnet.public.id
}