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

output details_map {
  description = "Tag display name is key, value contains all other tag details."
  value       = { for obj in local.tag_details : obj.tag_display_name => obj  }
}

output id_map {
  description = "Tag ID is key, value contains all other tag details."
  value       = { for obj in local.tag_details : obj.tag_name_id => obj  }
}