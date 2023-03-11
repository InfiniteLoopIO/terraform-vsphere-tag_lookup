# Terraform vSphere Tag Lookup

vSphere tagging differs from other providers in that it allows multiple cardinality of their tag categories (aka same tag category can be assigned multiple times) and each tag name must exist prior to being applied to a resource.

This Terraform module will lookup details about provided vSphere tags, which includes maps to display human friendly tag names vs vmomi IDs.

## Usage

Call the module given a map of existing tags to get their details.  

**Basic**
```hcl
module tag_lookup {
  source    = <path to module>
  
  tags      =  {
    environment      = ["dev"]
    point-of-contact = ["devops", "finance"]
  }
  separator = "="
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_tag.reference](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag) | data source |
| [vsphere_tag_category.reference](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag_category) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_separator"></a> [separator](#input\_separator) | (Optional) string character used to separate tag category and tag name | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags to be discovered, format is map with tag category as key and list of strings as tag names | `map(list(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_details_map"></a> [details\_map](#output\_details\_map) | Tag display name is key, value contains all other tag details. |
| <a name="output_id_map"></a> [id\_map](#output\_id\_map) | Tag ID is key, value contains all other tag details. |
<!-- END_TF_DOCS -->

## License

[Apache License, Version 2.0](LICENSE)