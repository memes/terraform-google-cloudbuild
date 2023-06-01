#
# Set from harness.tfvars
#
variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "gsr_repo" {
  type = string
}

#
# Set from kitchen.yml
#

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "disabled" {
  type    = bool
  default = false
}

variable "service_account" {
  type    = string
  default = ""
}

variable "tags" {
  type    = set(string)
  default = []
}

variable "ignored_files" {
  type    = list(string)
  default = []
}

variable "included_files" {
  type    = list(string)
  default = []
}

variable "substitutions" {
  type    = map(string)
  default = {}
}

variable "filename" {
  type    = string
  default = "cloudbuild.yml"
}

variable "dir" {
  type    = string
  default = ""
}

variable "invert_regex" {
  type    = bool
  default = false
}

variable "trigger_config" {
  type = object({
    is_pr_trigger   = bool
    branch_regex    = string
    tag_regex       = string
    comment_control = string
  })
  default = {
    is_pr_trigger   = false
    branch_regex    = null
    tag_regex       = ".*"
    comment_control = null
  }
}

variable "location" {
  type    = string
  default = "global"
}
