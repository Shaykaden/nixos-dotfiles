{ outputs, lib, ... }:
{
   programs.ssh = {
      enable = true;
   };

# home.persistence = {
#   "/persist/home/mizuho".directories = [ ".ssh" ];
# };
}
