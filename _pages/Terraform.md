## foreach loops

if supplied a dictionary like so;

    app = [
      {
        ecr_name       = "php-fpm",
        container_port = 9000,
        image_tags     = "1.0",
        task_memory    = 256,
        task_cpu       = 10,
        services       = ["php-fpm"],
        family         = ["php-app"],
        container_name = "php-fpm",
      },
      {
        ecr_name       = "nginx",
        container_port = 8080,
        image_tags     = "1.0",
        task_memory    = 512,
        task_cpu       = 10,
        services       = ["nginx"],
        family         = ["nginz-app"],
        container_name = "nginx",
      }
    ]

loop it within a module like so;

    data "template_file" "container_definitions" {
      template = "templates/container.json.tmpl"

      for_each = {
          for i in var.app : i.container_name => i
      }

      vars {
        container_name = lookup(each.value, "container_name", null)
        image_tags     = lookup(each.value, "image_tags", "latest")
      }
    }

## looping outputs

When outputting a map, do this;

    output "repository_arns" {
      value = {
        for repo, details in module.ecr : repo => details.arn
      }
    }

## testing variables (plus how to flatten)

If you want to test some logic without having to run it against
infrastructue, put your varaibles, logic and output into a single file
and run it.

eg. Put the following code into a main.tf file.

    variable "sso_permission_mappings" {
      default = [
        {
          # aws=acc-master (Root)
          "11111111111" : [
            {
              "permission_set" : "AWSReadOnlyAccess",
              "ad_group" : "AWS-All-ReadOnly",
            },
            {
              "permission_set" : "AWSAdministratorAccess",
              "ad_group" : "AWS-Master-Administrator",
            },
            {
              "permission_set" : "AWSReadOnlyAccess",
              "ad_group" : "AWS-Master-ReadOnly",
            },
          ],
        },
        {
          # Log Archive
          "222222222222" : [
            {
              "permission_set" : "AWSReadOnlyAccess",
              "ad_group" : "AWS-All-ReadOnly",
            },
            {
              "permission_set" : "AWSAdministratorAccess",
              "ad_group" : "AWS-LogArchive-Administrator",
            },
            {
              "permission_set" : "AWSReadOnlyAccess",
              "ad_group" : "AWS-LogArchive-ReadOnly",
            },
          ],
        },
      ]
    }

    locals {
      flat_permissionset_mappings = flatten([
        for accounts in var.sso_permission_mappings : [
          for account, mappings in accounts : [
            for mapped in mappings : {
              account        = account
              ad_group       = mapped["ad_group"]
              permission_set = mapped["permission_set"]
            }
          ]
        ]
      ])
    }


    output "flat_permissionset_mappings" {
      value = local.flat_permissionset_mappings
    }

When run, it can show you how the variable has been transformed

    $ tf plan

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:

    Terraform will perform the following actions:

    Plan: 0 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + flat_permissionset_mappings = [
          + {
              + account        = "1111111111111"
              + ad_group       = "AWS-All-ReadOnly"
              + permission_set = "AWSReadOnlyAccess"
            },
          + {
              + account        = "1111111111111"
              + ad_group       = "AWS-Master-Administrator"
              + permission_set = "AWSAdministratorAccess"
            },
          + {
              + account        = "1111111111111"
              + ad_group       = "AWS-Master-ReadOnly"
              + permission_set = "AWSReadOnlyAccess"
            },
          + {
              + account        = "22222222222222"
              + ad_group       = "AWS-All-ReadOnly"
              + permission_set = "AWSReadOnlyAccess"
            },
          + {
              + account        = "22222222222222"
              + ad_group       = "AWS-LogArchive-Administrator"
              + permission_set = "AWSAdministratorAccess"
            },
          + {
              + account        = "22222222222222"
              + ad_group       = "AWS-LogArchive-ReadOnly"
              + permission_set = "AWSReadOnlyAccess"
            },
        ]

## creating a map from tuples

When creating flattened tuple (as shown below), converting it into a map
will allow you to then lookup a value by the name. In this case, the ID
of the OU from its name

    variable "tuple" {
      default = [
        {
          account        = "111111111111111"
          ad_group       = "AWS-All-ReadOnly"
          permission_set = "AWSReadOnlyAccess"
        },
        {
          account        = "22222222222222"
          ad_group       = "AWS-LogArchive-Administrator"
          permission_set = "AWSAdministratorAccess"
        },
        {
          account        = "33333333333333333"
          ad_group       = "AWS-LogArchive-ReadOnly"
          permission_set = "AWSReadOnlyAccess"
        },
      ]
    }

    locals {
      ou_map = { for item in var.tuple :
        lookup(item, "account", "fail") => lookup(item, "ad_group", "fail")
      }
    }

    output "org_fix" {
      value = local.ou_map
    }

    output "selected" {
      value = lookup(local.ou_map, "22222222222222", "bugger")
    }

    tf plan                                                                                      TFv0.14.7

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:

    Terraform will perform the following actions:

    Plan: 0 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + org_fix = {
          + 111111111111111   = "AWS-All-ReadOnly"
          + 22222222222222    = "AWS-LogArchive-Administrator"
          + 33333333333333333 = "AWS-LogArchive-ReadOnly"
        }
      + vod     = "AWS-LogArchive-Administrator"