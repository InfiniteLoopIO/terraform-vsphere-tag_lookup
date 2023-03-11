# Terraform vSphere Tag Lookup - Demo Module

Demo merging common and specifict tags in `locals` block

Demo applying tags based on category filter for `tag_demo2` resource


**Terraform state list with descriptive keys vs numeric**
```hcl
data.vsphere_datacenter.dc
vsphere_folder.tag_demo1
vsphere_folder.tag_demo2
module.tag_lookup.data.vsphere_tag.reference["deployment-type=terraform"]
module.tag_lookup.data.vsphere_tag.reference["environment=dev"]
module.tag_lookup.data.vsphere_tag.reference["iac-managed=true"]
module.tag_lookup.data.vsphere_tag.reference["point-of-contact=devops"]
module.tag_lookup.data.vsphere_tag.reference["point-of-contact=finance"]
module.tag_lookup.data.vsphere_tag_category.reference["deployment-type"]
module.tag_lookup.data.vsphere_tag_category.reference["environment"]
module.tag_lookup.data.vsphere_tag_category.reference["iac-managed"]
module.tag_lookup.data.vsphere_tag_category.reference["point-of-contact"]
```

**Output with tag display name vs vmomi ID**
```hcl
folders = [
  {
    "datacenter_id" = "datacenter-2"
    "id" = "group-v19620"
    "path" = "tag_demo1"
    "tags" = tolist([
      "deployment-type=terraform",
      "environment=dev",
      "iac-managed=true",
      "point-of-contact=devops",
      "point-of-contact=finance",
    ])
    "type" = "vm"
  },
  {
    "datacenter_id" = "datacenter-2"
    "id" = "group-v19621"
    "path" = "tag_demo2"
    "tags" = tolist([
      "deployment-type=terraform",
      "environment=dev",
      "point-of-contact=devops",
      "point-of-contact=finance",
    ])
    "type" = "vm"
  },
]
```