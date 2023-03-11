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

variable "separator" {
  description = "(Optional) string character used to separate tag category and tag name"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "(Required) Tags to be discovered, format is map with tag category as key and list of strings as tag names"
  type        = map(list(string))
  
  validation {
    condition = length(var.tags) > 0
    error_message = "var.tags cannot be empty."
  }
  
  validation {
    condition = alltrue([
      for k,v in var.tags : length(v) == length(distinct(v))
    ])
    error_message = "All tag values must be unique."
  }
  #tag categories will be unique even if duplicates are provided since terraform will collapse them to a single key value pair
}
