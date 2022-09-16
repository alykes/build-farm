data "external" "wfh_public_ip" {
  program = ["cmd", "/C", "curl -s https://ipinfo.io/json"]
  #program = ["sh","-c", "curl -s https://ipinfo.io/json" ]
}