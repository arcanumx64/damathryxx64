{pkgs, ...}: {
    imports = [];
    environment.systemPackages = with pkgs; [
        grafana
        prometheus
        grafana-loki
        prometheus-systemd-exporter
        prometheus-node-exporter
    ];
}
