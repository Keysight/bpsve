locals {
	AgentMachineType = var.AgentMachineType
	Agent1InstanceId = "agent1"
	AppTag = "bps"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	Private1VpcNetworkPeerName = "${local.Preamble}-test1-vpc-peer"
	Private2VpcNetworkPeerName = "${local.Preamble}-test2-vpc-peer"
	PublicFirewallRuleSourceIpRanges = var.PublicFirewallRuleSourceIpRanges
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
}