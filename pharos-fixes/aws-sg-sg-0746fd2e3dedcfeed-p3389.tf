# IMPORTANT: Replace the cidr_blocks values below with your organization's
# approved CIDR ranges (e.g., corporate VPN CIDR, bastion host IP, or
# AWS Systems Manager Session Manager should be used instead of RDP where possible).
# Do NOT leave 0.0.0.0/0 in place. Example trusted CIDRs shown as placeholders.

resource "aws_security_group" "cybertalents_production_powerbi_sg" {
  name        = "cybertalents-production-powerbi-sg"
  description = "Security group for PowerBI production instance - RDP restricted to trusted CIDRs only"
  vpc_id      = "vpc-00d3e684759e4bfc6"

  # REMOVE the existing unrestricted RDP rule and replace with the restricted rule below.
  # Replace 203.0.113.0/24 with your actual corporate VPN or bastion CIDR block(s).
  ingress {
    description = "RDP access restricted to corporate VPN / bastion host only"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.0/24"] # REPLACE with your trusted CIDR(s), e.g. VPN gateway IP
    # Consider using AWS Systems Manager Session Manager to eliminate RDP exposure entirely
  }

  # Preserve any other existing ingress rules here (query current rules before applying)

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name               = "cybertalents-production-powerbi-sg"
    MigratedFrom       = "015061128280"
    OriginalName       = "powerbi"
    Project            = "DisasterRecovery"
    Environment        = "production"
    ManagedBy          = "Terraform"
    OriginalInstanceId = "i-01646fd2cd65e450f"
    RemediatedAt       = "2025-01-01"
    RemediationReason  = "CIS-benchmark-RDP-public-access-removed"
  }
}