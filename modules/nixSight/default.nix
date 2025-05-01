{pkgs, ...}: {
  imports = [];
  environment.systemPackages = with pkgs; [
    grafana # For visualization
    prometheus # For metrics collection
    promtail # For log shipping to Loki
    prometheus-node-exporter # For system metrics
    prometheus-process-exporter # For process monitoring
    prometheus-blackbox-exporter # For network probing
    prometheus-pushgateway # For custom metrics
    coredns # For DNS monitoring
    netdata # For real-time system monitoring
  ];

  services = {
    prometheus = {
      enable = true;
      port = 9090;
      retentionTime = "15d";
      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{targets = ["localhost:9100"];}];
        }
        {
          job_name = "prometheus";
          static_configs = [{targets = ["localhost:9090"];}];
        }
        {
          job_name = "process";
          static_configs = [{targets = ["localhost:9256"];}];
        }
        {
          job_name = "blackbox";
          static_configs = [{targets = ["localhost:9115"];}];
        }
        {
          job_name = "loki";
          static_configs = [{targets = ["localhost:3100"];}];
        }
        {
          job_name = "promtail";
          static_configs = [{targets = ["localhost:9080"];}];
        }
      ];
      exporters = {
        node = {
          enable = true;
          enabledCollectors = ["systemd"];
          port = 9100;
        };
        process = {
          enable = true;
          port = 9256;
        };
        blackbox = {
          enable = true;
          port = 9115;
          configFile = pkgs.writeText "blackbox.yml" ''
            modules:
              http_2xx:
                prober: http
                timeout: 5s
                http:
                  valid_status_codes: [200]
                  method: GET
          '';
        };
      };
    };

    grafana = {
      enable = true;
      settings = {
        server = {
          http_port = 3000;
          http_addr = "0.0.0.0";
        };
        security = {
          admin_user = "admin";
          admin_password = "$__file{/var/lib/grafana/admin_password}";
        };
      };
      provision = {
        enable = true;
        datasources = {
          settings = {
            datasources = [
              {
                name = "Prometheus";
                type = "prometheus";
                access = "proxy";
                url = "http://localhost:9090";
                isDefault = true;
              }
              {
                name = "Loki";
                type = "loki";
                access = "proxy";
                url = "http://localhost:3100";
              }
            ];
          };
        };
      };
    };

    loki = {
      enable = true;
      configuration = {
        auth_enabled = false;
        server = {
          http_listen_port = 3100;
          grpc_listen_port = 9096;
        };
        common = {
          path_prefix = "/var/lib/loki";
          storage = {
            filesystem = {
              chunks_directory = "/var/lib/loki/chunks";
              rules_directory = "/var/lib/loki/rules";
            };
          };
          replication_factor = 1;
          ring = {
            kvstore = {
              store = "inmemory";
            };
          };
        };
        schema_config = {
          configs = [
            {
              from = "2020-10-24";
              store = "boltdb-shipper";
              object_store = "filesystem";
              schema = "v11";
              index = {
                prefix = "index_";
                period = "24h";
              };
            }
          ];
        };
        limits_config = {
          reject_old_samples = true;
          reject_old_samples_max_age = "168h";
          allow_structured_metadata = false;
        };
        compactor = {
          working_directory = "/var/lib/loki/compactor";
        };
      };
    };

    promtail = {
      enable = true;
      configuration = {
        server = {
          http_listen_port = 9080;
          grpc_listen_port = 0;
        };
        positions = {
          filename = "/var/lib/promtail/positions.yaml";
        };
        clients = [
          {
            url = "http://localhost:3100/loki/api/v1/push";
          }
        ];
        scrape_configs = [
          {
            job_name = "journal";
            journal = {
              max_age = "12h";
              labels = {
                job = "systemd-journal";
                host = "localhost";
              };
            };
            relabel_configs = [
              {
                source_labels = ["__journal__systemd_unit"];
                target_label = "unit";
              }
            ];
          }
        ];
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000 # Grafana
      9090 # Prometheus
      3100 # Loki
      9100 # Node exporter
      9256 # Process exporter
      9115 # Blackbox exporter
    ];
  };

  # Create persistent directories
  systemd.tmpfiles.rules = [
    "d /var/lib/grafana 0700 grafana grafana - -"
    "d /var/lib/loki 0700 loki loki - -"
    "d /var/lib/loki/chunks 0700 loki loki - -"
    "d /var/lib/loki/rules 0700 loki loki - -"
    "d /var/lib/loki/compactor 0700 loki loki - -"
    "d /var/lib/promtail 0700 promtail promtail - -"
  ];
}
