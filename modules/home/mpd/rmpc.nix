{
  lib,
  os,
  ...
}:
lib.optionalAttrs os.mpd.rmpc {
  programs.rmpc.enable = true;
  programs.rmpc.config =
    # ron
    ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          address: "127.0.0.1:6600",
          password: None,
          theme: "theme",
          cache_dir: None,
          on_song_change: None,
          volume_step: 5,
          max_fps: 30,
          scrolloff: 0,
          wrap_navigation: false,
          enable_mouse: true,
          status_update_interval_ms: 1000,
          select_current_song_on_change: false,
          lyrics_dir: "/home/rein/music",
          album_art: (
              method: Auto,
              max_size_px: (width: 1200, height: 1200),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
          ),
          keybinds: (
              global: {
                  ":":       CommandMode,
                  ",":       VolumeDown,
                  "s":       Stop,
                  ".":       VolumeUp,
                  "<Tab>":   NextTab,
                  "<S-Tab>": PreviousTab,
                  "1":       SwitchToTab("Queue"),
                  "2":       SwitchToTab("Lyrics"),
                  "3":       SwitchToTab("Albums"),
                  "4":       SwitchToTab("Artists"),
                  "5":       SwitchToTab("Playlists"),
                  "6":       SwitchToTab("Directories"),
                  "7":       SwitchToTab("Search"),
                  "q":       Quit,
                  ">":       NextTrack,
                  "p":       TogglePause,
                  "<":       PreviousTrack,
                  "f":       SeekForward,
                  "z":       ToggleRepeat,
                  "x":       ToggleRandom,
                  "c":       ToggleConsume,
                  "v":       ToggleSingle,
                  "b":       SeekBack,
                  "~":       ShowHelp,
                  "I":       ShowCurrentSongInfo,
                  "O":       ShowOutputs,
                  "P":       ShowDecoders,
              },
              navigation: {
                  "k":         Up,
                  "j":         Down,
                  "h":         Left,
                  "l":         Right,
                  "<Up>":      Up,
                  "<Down>":    Down,
                  "<Left>":    Left,
                  "<Right>":   Right,
                  "<C-k>":     PaneUp,
                  "<C-j>":     PaneDown,
                  "<C-h>":     PaneLeft,
                  "<C-l>":     PaneRight,
                  "<C-u>":     UpHalf,
                  "N":         PreviousResult,
                  "a":         Add,
                  "A":         AddAll,
                  "r":         Rename,
                  "n":         NextResult,
                  "g":         Top,
                  "<Space>":   Select,
                  "<C-Space>": InvertSelection,
                  "G":         Bottom,
                  "<CR>":      Confirm,
                  "i":         FocusInput,
                  "J":         MoveDown,
                  "<C-d>":     DownHalf,
                  "/":         EnterSearch,
                  "<C-c>":     Close,
                  "<Esc>":     Close,
                  "K":         MoveUp,
                  "D":         Delete,
              },
              queue: {
                  "D":       DeleteAll,
                  "<CR>":    Play,
                  "<C-s>":   Save,
                  "a":       AddToPlaylist,
                  "d":       Delete,
                  "i":       ShowInfo,
                  "C":       JumpToCurrent,
              },
          ),
          search: (
              case_sensitive: false,
              mode: Contains,
              tags: [
                  (value: "any",         label: "Any Tag"),
                  (value: "artist",      label: "Artist"),
                  (value: "album",       label: "Album"),
                  (value: "albumartist", label: "Album Artist"),
                  (value: "title",       label: "Title"),
                  (value: "filename",    label: "Filename"),
                  (value: "genre",       label: "Genre"),
              ],
          ),
          artists: (
              album_display_mode: SplitByDate,
              album_sort_by: Date,
          ),
          tabs: [
              (
                  name: "Queue",
                  pane: Split(
                      direction: Horizontal,
                      panes: [(size: "40%", pane: Pane(AlbumArt)), (size: "60%", pane: Pane(Queue))],
                  ),
              ),
              (
                  name: "Lyrics",
                  pane: Pane(Lyrics),       
              ),
              (
                  name: "Albums",
                  pane: Pane(Albums),
              ),
              (
                  name: "Artists",
                  pane: Pane(AlbumArtists),
              ),
              (
                  name: "Playlists",
                  pane: Pane(Playlists),
              ),
              (
                  name: "Directories",
                  pane: Pane(Directories),
              ),
              (
                  name: "Search",
                  pane: Pane(Search),
              ),
          ],
      )
    '';

  home.file.".config/rmpc/themes/theme.ron".text = # ron
    ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          default_album_art_path: None,
          draw_borders: true,
          show_song_table_header: true,
          symbols: (song: "󰝚 ", dir: " ", marker: "󰒉 "),
          layout: Split(
              direction: Vertical,
              panes: [
                  (
                      pane: Pane(Tabs),
                      size: "3",    
                  ),
                  (
                      pane: Pane(TabContent),
                      size: "100%",
                  ),
                  (
                      pane: Pane(ProgressBar),
                      size: "1",
                  ),
                  (
                      pane: Pane(Header),
                      size: "1",
                  ),
              ],
          ),
          progress_bar: (
              symbols: ["━", "━", "━"],
              track_style: (),
              elapsed_style: (fg: "blue"),
              thumb_style: (fg: "blue"),
          ),
          scrollbar: (
              symbols: ["│", "█", "▲", "▼"],
              track_style: (),
              ends_style: (),
              thumb_style: (),
          ),
          browser_column_widths: [20, 38, 42],
          text_color: None,
          background_color: None,
          header_background_color: None,
          modal_background_color: None,
          modal_backdrop: false,
          tab_bar: (active_style: (fg: "black", bg: "blue", modifiers: "Bold"), inactive_style: ()),
          borders_style: (fg: "blue"),
          highlighted_item_style: (fg: "cyan", modifiers: "Bold"),
          current_item_style: (fg: "green", bg: "black", modifiers: "Bold"),
          highlight_border_style: (fg: "blue"),
          song_table_format: [
              (
                  prop: (kind: Property(Title), default: (kind: Text("Unknown"))),
                  width: "50%",
                  alignment: Right,
              ),
              (
                  prop: (kind: Property(Artist), style: (fg: "magenta"), default: (kind: Text("Unknown"))),
                  width: "50%",
              ),
          ],
          header: (
              rows: [
                  (
                      left: [
                          (kind: Property(Status(State)), style: (modifiers: "Bold")),
                          (kind: Text(": "), style: (modifiers: "Bold")),
                          (kind: Text(" "), style: (fg: "cyan", modifiers: "Bold")),
                          (kind: Property(Song(Album)), style: (modifiers: "Bold"),
                              default: (kind: Text("No Song"), style: (fg: "yellow", modifiers: "Bold"))
                          ),
                          (kind: Text("  "), style: (fg: "cyan", modifiers: "Bold")),
                      ],
                      center: [
                          (kind: Text("Vol: "), style: (modifiers: "Bold")),
                          (kind: Property(Status(Volume)), style: (modifiers: "Bold")),
                          (kind: Text("% ")),
                      ],
                      right: [
                          (kind: Text("["), style: (modifiers: "Bold")),
                          (kind: Property(Status(Elapsed)), style: (modifiers: "Bold")),
                          (kind: Text("/"), style: (modifiers: "Bold")),
                          (kind: Property(Status(Duration)), style: (modifiers: "Bold")),
                          (kind: Text("]"), style: (modifiers: "Bold")),
                      ]
                  )
              ],
          ),
      )
    '';
}
