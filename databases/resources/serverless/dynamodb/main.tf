
resource "aws_dynamodb_table" "dynamodb_table" {
  for_each = var.table_names

  name = "${local.app_name}-${each.key}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = each.value.keys.hash_key
  range_key = lookup(each.value.keys, "range_key", null)

  dynamic "attribute" {
    for_each = each.value.attributes

    content {
      name = attribute.key
      type = attribute.value
    }
  }
}