{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.toolchain.dotnet.enable = lib.mkEnableOption "C# and .NET toolchain.";

  config = lib.mkIf config.toolchain.dotnet.enable {
    home-manager.users.${config.user} = {
      
      home.packages = with pkgs; [
        msbuild # Microsoft Build Tools
        dotnetCorePackages.dotnet_8.sdk # .NET SDK
      ];

      home.sessionVariables = {
        DOTNET_RUNTIME = pkgs.dotnetCorePackages.dotnet_8.sdk;
      };
    };
  };
}