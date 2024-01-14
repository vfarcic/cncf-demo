let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    gum
    gh
    yq-go
    kubectl
    google-cloud-sdk
    awscli2
    eksctl
    azure-cli
    kustomize
    kubernetes-helm
    nodePackages.cdk8s-cli
    teller
  ];
}
