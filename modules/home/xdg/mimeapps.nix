{
  enable = true;
  defaultApplications =
    let
      editor = "Helix.desktop";
      browser = "librewolf.desktop";
      pdfViewer = "org.pwmt.zathura-pdf-mupdf.desktop";
      officeSuite = "startcenter.desktop";
      fileManager = "yazi.desktop";
      term = "kitty.desktop";
    in
    {
      "application/epub+zip" = pdfViewer;
      "application/oxps" = pdfViewer;
      "application/pdf" = pdfViewer;

      "application/msword" = "writer.desktop";
      "application/vnd.ms-excel" = "calc.desktop";
      "application/vnd.ms-powerpoint" = "impress.desktop";
      "application/vnd.oasis.opendocument.*" = officeSuite;
      "application/vnd.openxmlformats-officedocument.*" = officeSuite;

      "text/*" = editor;
      "application/toml" = editor;
      "application/x-yaml" = editor;

      "audio/*" = "asak.desktop";
      "image/*" = "imv.desktop";
      "video/*" = "mpv.desktop";

      "inode/directory" = fileManager;

      "application/zip" = fileManager;
      "application/x-tar" = fileManager;
      "application/x-gzip" = fileManager;
      "application/x-bzip2" = fileManager;
      "application/x-rar" = fileManager;
      "application/x-7z-compressed" = fileManager;

      "text/html" = browser;
      "x-scheme-handler/http*" = browser;

      "x-scheme-handler/terminal" = term;
      "application/x-sh" = term;
      "application/x-shellscript" = term;
      "x-scheme-handler/kitty" = term;
      "x-scheme-handler/ssh" = term;

      "application/x-ms-dos-executable" = "wine.desktop";
      "application/x-msdownload" = "wine.desktop";
      "application/x-msi" = "wine.desktop";
    };
}
