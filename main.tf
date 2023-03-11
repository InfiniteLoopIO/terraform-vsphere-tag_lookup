/*
Copyright 2023 infiniteloop.io

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

locals {
  
  tag_list = flatten([for tag_category,tag_name_list in var.tags : [for tag_name in tag_name_list : "${tag_category}${var.separator}${tag_name}" ]])
  
  unique_tag_pairs = toset(local.tag_list)
  
  tag_category_id_map = {for i in values(data.vsphere_tag_category.reference) : i.id => i}
  tag_name_id_map    = {for i in values(data.vsphere_tag.reference) : i.id => i}
  
  # flattened tag details used for output
  tag_details = [for tag in values(data.vsphere_tag.reference) : ({
      tag_display_name = "${local.tag_category_id_map[(local.tag_name_id_map[tag.id].category_id)].name}${var.separator}${local.tag_name_id_map[tag.id].name}"
      tag_category     = local.tag_category_id_map[(local.tag_name_id_map[tag.id].category_id)].name
      tag_category_id  = local.tag_name_id_map[tag.id].category_id
      tag_name         = local.tag_name_id_map[tag.id].name
      tag_name_id      = tag.id
    })
  ]
}

data "vsphere_tag_category" "reference" {    
  for_each = toset([for i in local.unique_tag_pairs : split(var.separator, i)[0]])
  name     = each.value
} 

data "vsphere_tag" "reference" {    
  for_each    = local.unique_tag_pairs
  name        = split(var.separator, each.value)[1]
  category_id = data.vsphere_tag_category.reference[split(var.separator, each.value)[0]].id
  
  depends_on = [
    data.vsphere_tag_category.reference
  ]
  
}
