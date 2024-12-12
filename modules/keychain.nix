{
  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [
      "~/.ssh/desktop"
      "~/.ssh/nnamacbook"
    ];
  };
}
