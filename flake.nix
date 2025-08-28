{
  description = "My NixOS configuration";

  nixConfig = { };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hardware.url = "github:nixos/nixos-hardware";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixos-generators, flake-parts, hardware, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;

      #import the variables from our vars.json file
      vars = builtins.fromJSON( builtins.readFile( ./resources/vars.json ) );

      pkgs-aarch64 = import nixpkgs { 
        config = {}; 
        
        system = "aarch64-linux";

        crossSystem = {
          config = "aarch64-unknown-linux-gnu";
        };

      };

      pkgs-x86_64 = import nixpkgs { 
        config = {}; 
        
        system = "x86_64-linux";
         
      }; 

      base-imports = ./imports/base-imports.nix;

      #make model array
      directories = lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./models);
      modelArr = lib.attrNames( directories );

      #define and instantiate the types of models you need
      model-types = {
        pi = {
          modules = [
            hardware.nixosModules.raspberry-pi-4
            ./hardware/hardware-configuration-aarch64.nix
            base-imports
          ];
          pkgs = pkgs-aarch64;
        };

        x86_64 = {
          modules = [ 
            ./hardware/hardware-configuration-x86_64.nix
            base-imports
          ];
          pkgs = pkgs-x86_64;
        };

        vm = {
          modules = [
            base-imports
          ];
          pkgs = pkgs-x86_64;
        };

      };
      
    in rec {
      
      requiredSystemFeatures = [ "kvm" ];

      # #elastically define standard models (pi)
      # elastic-models = lib.attrsets.mergeAttrsList( lib.forEach modelArr (modelName: { "${modelName}" = nixpkgs.lib.nixosSystem {

      #     modules = model-types.pi.modules ++ [
      #       ./models/${modelName}/default.nix
      #     ];

      #     specialArgs = { inherit inputs outputs hardware vars modelName;};
      #     pkgs = pkgs-aarch64;

      #   };
      # }));

      # "for every model-type"
      models = lib.attrsets.mergeAttrsList( lib.forEach (lib.attrNames model-types) (type:
      {

        "${type}" = lib.attrsets.mergeAttrsList( lib.forEach modelArr (model:
        {
          
          "${type}-${model}" = nixpkgs.lib.nixosSystem {

            modules = model-types."${type}".modules ++ [ 
              ./models/${model}/default.nix
            ]; 

            specialArgs = { inherit inputs outputs vars; modelName = "${type}-${model}"; };
            pkgs = model-types."${type}".pkgs;
          };

        }));
        
      }));

      #add all the elastic models and the test model to the configurations
      # nixosConfigurations = elastic-models // (lib.attrsets.mergeAttrsList (lib.attrsets.attrValues models));
      nixosConfigurations = (lib.attrsets.mergeAttrsList (lib.attrsets.attrValues models));

      vm = lib.attrsets.mergeAttrsList ( lib.forEach modelArr (model: {
        "${model}" = nixos-generators.nixosGenerate {

          modules = model-types.vm.modules ++ [
            ./models/${model}/default.nix
          ];
          
          specialArgs = { inherit inputs outputs vars; modelName = "vm-${model}"; };
          pkgs = model-types.vm.pkgs;

          system = "x86_64-linux";
          format = "vm";
        };
      }));
      
      sd = lib.attrsets.mergeAttrsList ( lib.forEach modelArr (model: {
        "${model}" = nixos-generators.nixosGenerate {
          
          modules = model-types.pi.modules ++ [
            ./models/${model}/default.nix
          ];

          specialArgs = { inherit inputs outputs vars; modelName = "pi-${model}"; };
          pkgs = model-types.pi.pkgs;

          system = "aarch64-linux";
          format = "sd-aarch64";
        
        };
      }));


      iso = lib.attrsets.mergeAttrsList ( lib.forEach modelArr (model: {
        "${model}" = nixos-generators.nixosGenerate {
          
          modules = model-types.x86_64.modules ++ [
            ./models/${model}/default.nix
          ];
          
          specialArgs = { inherit inputs outputs vars; modelName = "x86_64-${model}"; };
          pkgs = model-types.x86_64.pkgs;

          system = "x86_64-linux";
          format = "iso";
        };
      }));

  };
}
