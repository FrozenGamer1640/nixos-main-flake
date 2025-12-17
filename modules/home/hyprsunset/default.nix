{
  services.hyprsunset = {
    enable = true;
    settings.profile = [
      {
        time = "7:00";
        identity = true;
      }
      {
        time = "18:00";
        gamma = 0.95;
      }
      {
        time = "19:30";
        temperature = 5000;
        gamma = 0.9;
      }
      {
        time = "5:30";
        gamma = 0.95;
      }
    ];
  };
}
