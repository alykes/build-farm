data "external" "wfh_public_ip" {
  program = ["cmd", "/C", "curl -s https://ipinfo.io/json --ssl-no-revoke"]
  #program = ["sh","-c", "curl -s https://ipinfo.io/json --ssl-no-revoke" ]
}
