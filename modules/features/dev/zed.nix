{
  # TODO : keybinds
  flake.homeModules.zed = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;
      defaultEditor = true;

      extensions = [
        "nix"
        "charmed-icons"
        "toml"
        "tombi"
      ];

      extraPackages = with pkgs; [
        nixd
        nil
        ruff
        basedpyright
      ]; # need lsp install for zed

      userSettings = {
        vim_mode = true;

        vim = {
          toggle_relative_line_numbers = true;
        };

        title_bar = {
          show_sign_in = false;
        };

        lsp = {
          nix = {
            binary = {
              path_lookup = true;
            };
          };

          basedpyright = {
            settings = {
              basedpyright = {
                analysis = {
                  diagnosticMode = "workspace";
                  typeCheckingMode = "standard";
                  autoImportCompletions = true;
                };
              };
            };
          };

          ruff = {
            initialization_options = {
              settings = {
                lineLength = 88;
              };
            };
          };
        };

        git = {
          inline_blame = {
            location = "status_bar";
            show_commit_summary = false;
            enabled = false;
          };

          git_gutter = "tracked_files";
        };

        debugger = {
          save_breakpoints = true;
        };

        collaboration_panel = {
          button = false;
        };

        git_panel = {
          show_count_badge = false;
          diff_stats = true;
          folder_indicator = true;
          file_icons = false;
          tree_view = true;
          collapse_untracked_diff = false;
          status_style = "icon";
          button = true;
        };

        outline_panel = {
          button = false;
        };

        terminal = {
          show_count_badge = false;
          flexible = true;
          starts_open = false;
        };

        project_panel = {
          hide_hidden = false;
          hide_root = false;

          indent_guides = {
            show = "always";
          };

          git_status_indicator = false;
          bold_folder_labels = false;
          auto_reveal_entries = true;
          indent_size = 20.0;
          git_status = true;
          entry_spacing = "comfortable";
          default_width = 255.0;
          hide_gitignore = false;
          dock = "right";
        };

        window_decorations = "client";
        use_system_window_tabs = false;

        centered_layout = {
          left_padding = 0.2;
        };

        bottom_dock_layout = "contained";

        preview_tabs = {
          enable_keep_preview_on_code_navigation = true;
          enable_preview_multibuffer_from_code_navigation = true;
          enable_preview_from_file_finder = true;
        };

        tab_bar = {
          show_pinned_tabs_in_separate_row = false;
        };

        tabs = {
          show_close_button = "hidden";
          show_diagnostics = "off";
          file_icons = true;
          git_status = false;
        };

        search = {
          whole_word = false;
        };

        completions = {
          lsp_fetch_timeout_ms = 1;
        };

        document_folding_ranges = "off";
        document_symbols = "off";
        code_lens = "off";

        inlay_hints = {
          enabled = false;
        };

        format_on_save = "on";
        indent_guides = {
          active_line_width = 2;
          line_width = 2;
          background_coloring = "disabled";
          coloring = "indent_aware";
        };

        toolbar = {
          code_actions = false;
          breadcrumbs = true;
        };

        minimap = {
          show = "never";
        };

        scroll_beyond_last_line = "one_page";
        autosave = "on_focus_change";
        unnecessary_code_fade = 0.3;
        buffer_line_height = "comfortable";

        diagnostics = {
          inline = {
            update_debounce_ms = 0;
            padding = 4;
            enabled = true;
          };
        };

        languages = {
          Nix = {
            format_on_save = "on";
          };
          Python = {
            tab_size = 4;
            hard_tabs = false;
            preferred_line_length = 88;

            format_on_save = "on";

            formatter = {
              language_server = {
                name = "ruff";
              };
            };

            # Organisation des imports et corrections automatiques
            code_actions_on_format = {
              "source.organizeImports.ruff" = false;
              "source.fixAll.ruff" = false;
            };

            # Serveurs de langage
            language_servers = [
              "basedpyright"
              "ruff"
            ];
          };
        };

        telemetry = {
          diagnostics = false;
          metrics = false;
          anthropic_retention = false;
        };

        base_keymap = "VSCode";
        icon_theme = {
          mode = "dark";
          light = "Zed (Default)";
          dark = "Soft Charmed Icons";
        };

        theme = {
          mode = "dark";
          light = "One Light";
          dark = "One Dark";
        };

        auto_install_extensions = {
          nix = true;
          "Charmed Icons" = true;
        };
      };
    };
  };
}
