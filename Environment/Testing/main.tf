module "rgmodule" {
  source    = "../../Resources/RG"
  rgdetails = var.rgvar
}
module "rgvnet" {
  depends_on = [module.rgmodule]
  source     = "../../Resources/VNET"
  vnet1      = var.vnet9
}
module "myacr" {
  depends_on = [module.rgmodule, module.akscluster1]
  source     = "../../Resources/ACR"
  acrdetails = var.acrrole
}
module "akscluster1" {
  depends_on  = [module.rgmodule]
  source      = "../../Resources/AKS"
  akscluster1 = var.aksghor
}
module "mynic" {
  depends_on = [module.mysubnet5, module.rgvnet, module.rgmodule, ]
  source     = "../../Resources/NIC"
  mynic      = var.nic1
}
module "mysubnet5" {
  depends_on = [module.rgmodule, module.rgvnet]
  source     = "../../Resources/SUBNET"
  mysubnet1  = var.mysubnet5
}
module "mykeyvault45" {
  depends_on = [module.rgmodule, module.rgvnet]
  source     = "../../Resources/KEYVAULT"
  mykeyvault = var.mykeyvault49
}
module "mynewvm" {
  depends_on = [module.rgmodule, module.rgvnet, module.mykeyvault45, module.mynic  ]
  source = "../../Resources/VM"
  myvm1 = var.labvm
}