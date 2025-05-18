{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      {
        appId = "com.obsproject.Studio";
        origin = "flathub";
      }
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
      {
        appId = "md.obsidian.Obsidian";
        origin = "flathub";
      }
    ];
    update.auto.enable = true;
    update.auto.onCalendar = "daily";
  };
}
