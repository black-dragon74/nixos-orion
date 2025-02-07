{ pkgs, ... }:

{
  programs.msmtp = {
    enable = true;
    defaults = {
      port = 465;
      tls = true;
      tls_starttls = false;
    };
    accounts.default = {
      auth = true;
      host = "mailer.srv01-prod.ydvnick.cc";
      from = "msmtp@mailer.srv01-prod.ydvnick.cc";
      domain = "mailer.srv01-prod.ydvnick.cc";
      user = "mailer";
      passwordeval = "cat /secrets/msmtp_creds.txt";
    };
  };
}
