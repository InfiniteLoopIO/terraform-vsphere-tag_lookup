# output with tag display name vs "urn:vmomi:InventoryServiceTag:11111111-2222-3333-4444-555555555555:GLOBAL"
output "folders" {
  value = [for i in [resource.vsphere_folder.tag_demo1, resource.vsphere_folder.tag_demo2] : ({
            id   = i.id
            path = i.path
            tags = sort([for tag_name_id in i.tags :
              module.tag_lookup.id_map[tag_name_id].tag_display_name
            ])
            type = i.type
            datacenter_id = i.datacenter_id
          })]
}
