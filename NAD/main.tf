terraform {
  required_providers {
    ciscoise = {
      source = "CiscoISE/ciscoise"
      version = "0.7.0-beta"
    }
  }
}

provider "ciscoise" {
  username = "admin"
  password = "C1sco12345!"
  base_url = "https://10.71.130.8"
  debug = "true"
  ssl_verify = "false"
  use_api_gateway = "false"
  use_csrf_token = "false"
  single_request_timeout = 60
}

provider "ciscoise" {
  username = data.terraform_remote_state.credentials
  password = var.ciscoise_password
  base_url = var.ciscoise_base_url
  ssl_verify = "false"
  single_request_timeout = 150
}

resource "ciscoise_network_device" "example" {
  provider = ciscoise
  parameters {

    name          = "Cat9300TMT07"
    description   = "nad_create"
    coa_port      = 1700
    profile_name  = "Cisco"
 
    network_device_group_list = ["IPSEC#Is IPSEC Device#No","Location#All Locations","Device Type#All Device Types"]

    network_device_iplist {

      ipaddress             = "172.16.1.13"
      mask                  = 32
    }
    authentication_settings {

      network_protocol               = "RADIUS"
      radius_shared_secret           = "C1sco12345!"
      enable_multi_secret            = "false"
      dtls_required                  = "false"
      enable_key_wrap                = "false"
      key_input_format               = "ASCII"

    }

    trustsecsettings {

      device_authentication_settings {
        sga_device_id       = "F0C2203Z051"
        sga_device_password = "F0C2203Z051"
      }      

      device_configuration_deployment {

        enable_mode_password               = "C1sco12345!"
        exec_mode_password                 = "C1sco12345!"
        exec_mode_username                 = "cisco"
        include_when_deploying_sgt_updates = "true"
      
      }
    
      sga_notification_and_updates {

        downlaod_environment_data_every_x_seconds          = 86400
        downlaod_peer_authorization_policy_every_x_seconds = 86400
        download_sga_cllists_every_x_seconds               = 86400
        other_sga_devices_to_trust_this_device             = "true"
        re_authentication_every_x_seconds                  = 86400
        send_configuration_to_device                       = "true"
        send_configuration_to_device_using                 = "ENABLE_USING_COA"
        coa_source_host                                    = "CPOC-ISE"
      }
    }
  }
}