locals{
  #separator value used in split(), do not use single character sequential value which may exist in your tag category or tag name
  separator = "="

  common_tags = {
    environment      = ["test"]
    deployment-type  = ["terraform"]
    iac-managed      = ["true"]
  }
  
  tag_demo = {
    environment      = ["dev"]
    point-of-contact = ["devops", "finance"]
  }
  
  # pass this merged map object to enumerate already existing tag categories and names
  merged_tags = merge(local.common_tags, local.tag_demo)
  
  # this list contains "<tag_category><separator><tag_value>" strings used to lookup display name for output folders {} block
  merged_tags_flat = flatten([for tcat,tval in local.merged_tags : [for i in tval : "${tcat}${local.separator}${i}"]])
  
}

module tag_lookup {
  source = "../../"
  
  tags      = local.merged_tags
  separator = local.separator
}

data "vsphere_datacenter" "dc" {
  # lab only has one datacenter, name not required
}

# apply all supplied tags
resource "vsphere_folder" "tag_demo1" {
  path          = "tag_demo1"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
  
  tags = [
    for i in local.merged_tags_flat : module.tag_lookup.details_map[i].tag_name_id
  ]
}

# apply all tags except those with category "iac-managed"
resource "vsphere_folder" "tag_demo2" {
  path          = "tag_demo2"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
  
  tags = [
    for i in local.merged_tags_flat : module.tag_lookup.details_map[i].tag_name_id 
    if module.tag_lookup.details_map[i].tag_category != "iac-managed"
  ]
}