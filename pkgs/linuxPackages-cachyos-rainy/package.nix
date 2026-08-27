{
  linuxKernel,
  linux-cachyos-rainy,
  cachyosHelpers,
}:
cachyosHelpers.kernelModuleLLVMOverride (linuxKernel.packagesFor linux-cachyos-rainy)
