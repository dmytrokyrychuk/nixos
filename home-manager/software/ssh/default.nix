{ ... }: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host nixos.home.kyrych.uk
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
        User nixos
        LogLevel QUIET

      Host *.2li.local
        User andreas
        IdentityFile ~/.nixos/secrets/ssh_keys/ansible/ansible.key

      Host 10.7.89.*
        User andreas
        IdentityFile ~/.nixos/secrets/ssh_keys/ansible/ansible.key
    '';
  };
}
