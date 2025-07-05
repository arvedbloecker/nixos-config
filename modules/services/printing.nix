{
   pkgs, ...
}:
{
  services = {
    printing.enable = true;

    printing.drivers = with pkgs; [
      brlaser
    ];

    avahi.enable = true;
    avahi.openFirewall = true;
    avahi.nssmdns4 = true;
    printing.browsing = true;

  };

  hardware.printers = {
    # Find the Printer with avahi-browse
    ensurePrinters = [
      {
        name = "Brother_HL2350SW";
        location = "Home";
        deviceUri = "ipp://BRWB4B5B6E4172A.local:631/ipp/print";
        model = "drv:///brlaser.drv/brl2350d.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Brother_HL2350SW";
  };

  
}
