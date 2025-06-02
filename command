Import-Module /root/azure/azure_exports/rohitazmap/rohitazmap/rohitazmap.psd1 -Force
Get-Command -Module rohitazmap
Export-rohitazmap -ResourceGroup `
"abhay-tfstate", "ADDSLAB", "Akshay-RG", "Amber-RG", "Anurag-RG", "Ashish_RG", "Ayush-RG", `
"AzureBackupRG_eastus_1", "AzureBackupRG_westus_1", "cloud-shell-storage-centralindia", `
"Contoso", "Contoso-southeastasia", "DefaultResourceGroup-CCAN", "DefaultResourceGroup-CIN", `
"DefaultResourceGroup-EAU", "DefaultResourceGroup-EUS", "DefaultResourceGroup-EUS2", `
"DefaultResourceGroup-WEU", "DefaultResourceGroup-WUS", "demorg476", "Devansh-RG", "GWB-RG", `
"Hitesh-RG", "Ishika-RG", "jana-rg", "Janardhana-RG", "Lab03_RLrg", "Manikanta_V", "Manuj-rg", `
"May-RG", "MyLearningRG", "myResourceGroup", "Nakul-RG", "Nakul_RG", "NetworkWatcherRG", `
"New_RG", "Nitesh-RG", "Patching_Test_VM", "PatchingSnapshots", "Poornima-RG", `
"PrePatchingRG-VisualStudioEnterpriseSubscription", "PUNEETH-rg", "ravi1", "ravi2", `
"Ravinder-RG-asr", "RavinLRRavinLRG", "ResourceMoverRG-eastus-southeastasia-sea", "Rohit_InfraOps", `
"Roopesh_tfstate", "Sabah-RG", "sachin-rg", "sumandevops_rg", "sumanrg", "test-migration", `
"Test-RG", "test1_group", "test4_group", "test_rg", "TestEnvironment_RG", "TestRG-H", `
"testVm2_group", "Update_manager", "Vikash_RG", "VikRg", "WSUS01-Test_group", "Yukta-RG" `
-Theme Light -OutputFilePath "./diagrams/map.png" -Show:$false

Command2
Export-rohitazmap -ResourceGroup `
"abhay-tfstate", "ADDSLAB", "Akshay-RG", "Amber-RG", "Anurag-RG", "Ashish_RG", "Ayush-RG", `
"AzureBackupRG_eastus_1", "AzureBackupRG_westus_1", "cloud-shell-storage-centralindia", `
"Contoso", "Contoso-southeastasia", "DefaultResourceGroup-CCAN", "DefaultResourceGroup-CIN", `
"DefaultResourceGroup-EAU", "DefaultResourceGroup-EUS", "DefaultResourceGroup-EUS2", `
"DefaultResourceGroup-WEU", "DefaultResourceGroup-WUS", "demorg476", "Devansh-RG", "GWB-RG", `
"Hitesh-RG", "Ishika-RG", "jana-rg", "Janardhana-RG", "Lab03_RLrg", "Manikanta_V", "Manuj-rg", `
"May-RG", "MyLearningRG", "myResourceGroup", "Nakul-RG", "Nakul_RG", "NetworkWatcherRG", `
"New_RG", "Nitesh-RG", "Patching_Test_VM", "PatchingSnapshots", "Poornima-RG", `
"PrePatchingRG-VisualStudioEnterpriseSubscription", "PUNEETH-rg", "ravi1", "ravi2", `
"Ravinder-RG-asr", "RavinLRRavinLRG", "ResourceMoverRG-eastus-southeastasia-sea", "Rohit_InfraOps", `
"Roopesh_tfstate", "Sabah-RG", "sachin-rg", "sumandevops_rg", "sumanrg", "test-migration", `
"Test-RG", "test1_group", "test4_group", "test_rg", "TestEnvironment_RG", "TestRG-H", `
"testVm2_group", "Update_manager", "Vikash_RG", "VikRg", "WSUS01-Test_group", "Yukta-RG" `
-LabelVerbosity 2 `
-CategoryDepth 2 `
-Theme light `
-OutputFormat svg `
-OutputFilePath "/root/azure/azure_exports/rohitdiagen/azinfra_full.svg" `
-Show:$false `
-Verbose
