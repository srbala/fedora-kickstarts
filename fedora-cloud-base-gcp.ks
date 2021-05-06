# This is a basic Fedora cloud spin designed to work with GCP.
# Note that GCP prefers UEFI so we'll need to make sure this image
# is created from a machine that is started in UEFI mode.

# Inherit from cloud base
%include fedora-cloud-base.ks

# Change serial port configuration to recommended default for GCP (ttyS0,38400n8d)
# Don't show bootloader as it's impossible for the user to get to it in time
# So we might as well not waste the 1 second on each boot.
# https://cloud.google.com/compute/docs/import/import-existing-image
bootloader --timeout=0 --append="no_timer_check net.ifnames=0 console=ttyS0,38400n8d"

# redefine `services` here to drop cloud-init systemd unit enablements from
# fedora-cloud-base.ks since we don't use them.
services --enabled=sshd

%packages
# GCP provides its own guest environment.
+google-compute-engine-guest-configs
-cloud-init
# Fedora Cloud Base includes the qemu guest agent. GCP prefers
# that it not be installed  https://pagure.io/cloud-sig/issue/319
-qemu-guest-agent
%end

%post --erroronfail
cat <<EOF > /etc/NetworkManager/conf.d/gcp-mtu.conf
# In GCP it is recommended to use 1460 as the MTU.
# Set it to 1460 for all connections.
# https://cloud.google.com/network-connectivity/docs/vpn/concepts/mtu-considerations
[connection]
ethernet.mtu = 1460
EOF
%end
