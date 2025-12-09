{
  inputs = {
    hosts = {
      type = "path";
      path = "./hosts";
    };
    users = {
      type = "path";
      path = "./users";
    };
  };

  outputs =
    {
      hosts,
      users,
      ...
    }:
    {
      inherit (hosts) nixosConfigurations;
      inherit (users) homeConfigurations;
    };
}
